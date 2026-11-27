import Lean
import Lean.Replay

namespace Golfcheck

open Lean

private def allowAxioms : Array Name := #[`propext, `Classical.choice, `Quot.sound]

private def theoremFrom (data : ModuleData) (name : Name) : IO TheoremVal := do
  match data.constants.find? (·.name == name) with
  | some (.thmInfo thm) => return thm
  | some _ => throw <| IO.userError s!"{name} must be a theorem"
  | none => throw <| IO.userError s!"missing local theorem {name}"

-- Binder names may be generated with module-specific scopes. Keep binder
-- annotations and de Bruijn indices, which carry the declaration's structure.
private partial def canonicalBinders : Expr → Expr
  | .forallE _ type body info => .forallE .anonymous (canonicalBinders type) (canonicalBinders body) info
  | .lam _ type body info => .lam .anonymous (canonicalBinders type) (canonicalBinders body) info
  | .letE _ type value body nondep =>
    .letE .anonymous (canonicalBinders type) (canonicalBinders value) (canonicalBinders body) nondep
  | .app fn arg => .app (canonicalBinders fn) (canonicalBinders arg)
  | .mdata _ expr => canonicalBinders expr
  | .proj type index expr => .proj type index (canonicalBinders expr)
  | expr => expr

private def canonicalType (thm : TheoremVal) : Expr :=
  let levels := thm.levelParams.zipIdx.map fun (_, i) => Level.param (.num .anonymous i)
  canonicalBinders (thm.type.instantiateLevelParams thm.levelParams levels)

private def sameStatement (reference : TheoremVal) (referenceType : Expr) (submission : TheoremVal) :
    Bool :=
  submission.levelParams.length == reference.levelParams.length &&
    referenceType.equal (canonicalType submission)

private def fingerprint (thm : TheoremVal) (type : Expr) : String :=
  s!"{thm.levelParams.length}\n{type}"

-- The compiler emits unsafe executable implementations for some safe recursive
-- packet definitions. Only the kernel definitions belong in the certificate.
private def recursiveImplementations (reference : ModuleData) : NameSet := Id.run do
  let mut names : NameSet := {}
  for info in reference.constants do
    if let some parent := Compiler.isUnsafeRecName? info.name then
      if info.isPartial && reference.constants.any (fun candidate =>
          candidate.name == parent && (candidate matches .defnInfo _) &&
            !candidate.isUnsafe && !candidate.isPartial) then
        names := names.insert info.name
  return names

-- Follow compiler-generated local helpers, but stop at the imported library boundary.
private partial def forbiddenDependency (localConstants : Std.HashMap Name ConstantInfo)
    (forbidden : List String) (pending : List Name) (seen : NameSet := {}) : Option Name :=
  match pending with
  | [] => none
  | name :: rest =>
    if name == `Lean.ofReduceBool || forbidden.contains name.toString then
      some name
    else if let some info := localConstants[name]? then
      if seen.contains name then forbiddenDependency localConstants forbidden rest seen
      else forbiddenDependency localConstants forbidden
        (info.getUsedConstantsAsSet.toList ++ rest) (seen.insert name)
    else
      forbiddenDependency localConstants forbidden rest seen

private def certificateEnvironment (data : ModuleData) (allowed : List String)
    (implementations : NameSet) (cachedImports : Option Environment := none) :
    IO (Environment × Std.HashMap Name ConstantInfo) := do
  for imp in data.imports do
    unless (imp.module == `Init || allowed.contains imp.module.toString) && !imp.importAll do
      throw <| IO.userError s!"unapproved compiled import {imp.module}"
  let imports ← match cachedImports with
    | some env => pure env
    | none => importModules data.imports {}
  let mut localConstants : Std.HashMap Name ConstantInfo := {}
  for constant in data.constants do
    if constant.isPartial && implementations.contains constant.name then
      continue
    if constant.isUnsafe || constant.isPartial then
      throw <| IO.userError s!"disallowed generated declaration {constant.name}"
    if imports.contains constant.name || localConstants.contains constant.name then
      throw <| IO.userError s!"submission redefines constant {constant.name}"
    localConstants := localConstants.insert constant.name constant
  -- Replay the compiled certificate from the source module, with no submission initializers.
  let env ← imports.replay localConstants
  return (env, localConstants)

def fingerprintStatementData (data draft : ModuleData) (name : Name) (allowed : List String)
    (cachedImports : Option Environment := none) : IO String := do
  let thm ← theoremFrom data name
  let type := canonicalType thm
  unless sameStatement thm type (← theoremFrom draft name) do
    throw <| IO.userError "the submission template type differs from Statement.lean"
  let implementations := recursiveImplementations data
  let (env, _) ← certificateEnvironment data allowed implementations cachedImports
  -- The placeholder proof is allowed here. Its type and the packet's other
  -- declarations must be independent of it and of any other nonstandard axiom.
  let dependencies := thm.type.getUsedConstants.toList ++
    (data.constants.toList.filterMap fun info =>
      if info.name == name || implementations.contains info.name then none else some info.name)
  for dependency in dependencies do
    let axioms ← Core.CoreM.toIO' (collectAxioms dependency)
      { fileName := "<statement>", fileMap := default } { env }
    if let some disallowed := axioms.find? (!allowAxioms.contains ·) then
      throw <| IO.userError s!"statement depends on disallowed axiom {disallowed} through {dependency}"
  return fingerprint thm type

def fingerprintStatement (referencePath draftPath : System.FilePath) (name : Name)
    (allowed : List String) : IO String := do
  let (data, _) ← readModuleData referencePath
  let (draft, _) ← readModuleData draftPath
  fingerprintStatementData data draft name allowed

private def inspectProof (data : ModuleData) (thm : TheoremVal) (forbidden allowed : List String)
    (implementations : NameSet) :
    IO (Array Name × String) := do
  let (env, localConstants) ← certificateEnvironment data allowed implementations
  let axioms ← Core.CoreM.toIO' (collectAxioms thm.name)
    { fileName := "<certificate>", fileMap := default } { env }
  if let some disallowed := axioms.find? (!allowAxioms.contains ·) then
    return (axioms, s!"disallowed axiom {disallowed}")
  if let some localAxiom := data.constants.find? (· matches .axiomInfo _) then
    return (axioms, s!"disallowed generated axiom {localAxiom.name}")
  if let some dependency := forbiddenDependency localConstants forbidden thm.value.getUsedConstants.toList then
    return (axioms, s!"forbidden constant {dependency}")
  return (axioms, "")

def verify (referencePath submissionPath : System.FilePath) (name : Name)
    (forbidden allowed : List String) : IO Json := do
  let (referenceData, _) ← readModuleData referencePath
  let reference ← theoremFrom referenceData name
  let referenceType := canonicalType reference
  let (submissionData, _) ← readModuleData submissionPath
  let submission ← theoremFrom submissionData name
  let (axioms, reason) ← if !sameStatement reference referenceType submission then
    pure (#[], "statement type differs from Statement.lean")
  else
    inspectProof submissionData submission forbidden allowed (recursiveImplementations referenceData)
  return Json.mkObj [("fingerprint", toJson (fingerprint reference referenceType)),
    ("axioms", toJson (axioms.map Name.toString)), ("reason", toJson reason)]

end Golfcheck
