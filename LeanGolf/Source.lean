import Lean

namespace Golfcheck

open Lean Parser

private def bannedTokens : Array String := #[
  "sorry", "admit", "native_decide", "Lean.ofReduceBool", "ofReduceBool",
  "axiom", "opaque", "macro", "macro_rules", "syntax", "notation", "infix",
  "infixl", "infixr", "prefix", "postfix", "elab", "elab_rules",
  "run_cmd", "run_tac", "run_elab", "run_meta", "by_elab", "include_str",
  "#eval", "#exit", "set_option",
  "attribute", "@[", "implemented_by", "extern", "csimp", "unsafe", "partial",
  "namespace", "section", "open", "variable", "universe"
]

private partial def bannedToken? : Syntax → Option String
  | .node _ _ args => args.findSome? bannedToken?
  | .atom _ text => if bannedTokens.contains text then some text else none
  | .ident _ _ name _ =>
    let text := (name.replacePrefix `_root_ .anonymous).toString
    if bannedTokens.contains text then some text else none
  | .missing => none

private def rejectTokens (stx : Syntax) : IO Unit := do
  if let some token := bannedToken? stx then
    throw <| IO.userError s!"banned token {token}"

private def checkSyntaxErrors (messages : MessageLog) : IO Unit := do
  if let some msg := messages.toList.find? (·.severity == .error) then
    throw <| IO.userError s!"line {msg.pos.line}, column {msg.pos.column}: {(← msg.data.toString).trimAscii}"

-- Only trusted imports are loaded, and no submission command is elaborated here.
unsafe def proofOffset (source expectedName : String) (allowed : List String) : IO Nat := do
  let input := mkInputContext source "Submission.lean"
  let (header, state, messages) ← parseHeader input
  checkSyntaxErrors messages
  unless header.raw[0].isNone && header.raw[1].isNone do
    throw <| IO.userError "module and prelude headers are forbidden"
  for entry in header.raw[2].getArgs do
    let `(Module.import| import $name) := entry
      | throw <| IO.userError "expected a plain import"
    unless allowed.contains name.getId.toString do
      throw <| IO.userError s!"unapproved import {name.getId}"
  enableInitializersExecution
  let env ← importModules (Elab.HeaderSyntax.imports header) {} (loadExts := true)
  let ctx : ParserModuleContext := { env, options := {} }
  let (command, state, messages) := parseCommand input ctx state messages
  rejectTokens command
  checkSyntaxErrors messages
  let theoremStx := command[1]
  unless command.isOfKind ``Command.declaration && theoremStx.isOfKind ``Command.theorem &&
      command[0].getArgs.all Syntax.isNone do
    throw <| IO.userError "expected one plain theorem declaration"
  let name := theoremStx[1][0].getId
  unless name.toString == expectedName do
    throw <| IO.userError s!"theorem name {name} does not match {expectedName}"
  let value := theoremStx[3]
  unless value.isOfKind ``Command.declValSimple && value[2].getArgs.all Syntax.isNone &&
      value[3].isNone do
    throw <| IO.userError "expected a theorem body after := without declaration suffixes"
  let (next, _, messages) := parseCommand input ctx state messages
  rejectTokens next
  unless next.isOfKind ``Command.eoi do
    throw <| IO.userError "expected exactly one theorem and no other commands"
  checkSyntaxErrors messages
  let some offset := value[0].getTailPos?
    | throw <| IO.userError "missing := proof separator"
  return offset.byteIdx

end Golfcheck
