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

def checkSyntaxErrors (messages : MessageLog) : IO Unit := do
  if let some msg := messages.toList.find? (·.severity == .error) then
    throw <| IO.userError s!"line {msg.pos.line}, column {msg.pos.column}: {(← msg.data.toString).trimAscii}"

def plainHeader (input : InputContext) (allowed : List String) :
    IO (Array Import × ModuleParserState × Nat) := do
  let (header, state, messages) ← parseHeader input
  checkSyntaxErrors messages
  unless header.raw[0].isNone && header.raw[1].isNone do
    throw <| IO.userError "module and prelude headers are forbidden"
  for entry in header.raw[2].getArgs do
    let `(Module.import| import $name) := entry
      | throw <| IO.userError "expected a plain import"
    unless allowed.contains name.getId.toString do
      throw <| IO.userError s!"unapproved import {name.getId}"
  return (Elab.HeaderSyntax.imports header, state, header.raw.getTailPos?.getD 0 |>.byteIdx)

def parserContext (state : Elab.Command.State) : ParserModuleContext :=
  let scope := state.scopes.head!
  { env := state.env, options := scope.opts,
    currNamespace := scope.currNamespace, openDecls := scope.openDecls }

def elaborateContext (env : Environment) (preamble : String) (opts : Options) :
    IO Elab.Command.State := do
  let commandState := Elab.Command.mkState env {} opts
  if preamble.isEmpty then return commandState
  let trusted ← Elab.IO.processCommands (mkInputContext preamble "PacketContext.lean")
    {} commandState
  checkSyntaxErrors trusted.commandState.messages
  return trusted.commandState

def checkedProofOffset (input : InputContext) (ctx : ParserModuleContext)
    (state : ModuleParserState) (expectedName : String) : IO Nat := do
  let (command, state, messages) := parseCommand input ctx state {}
  rejectTokens command
  checkSyntaxErrors messages
  let theoremStx := command[1]
  unless command.isOfKind ``Command.declaration && theoremStx.isOfKind ``Command.theorem &&
      command[0].getArgs.all Syntax.isNone do
    throw <| IO.userError "expected one plain theorem declaration"
  let name := theoremStx[1][0].getId
  let resolvedName := if name.getRoot == `_root_ then name.replacePrefix `_root_ .anonymous
    else ctx.currNamespace ++ name
  unless resolvedName.toString == expectedName do
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

-- Only trusted imports and packet context are elaborated here.
unsafe def proofLayout (source expectedName preamble : String) (allowed : List String) :
    IO (Nat × Nat) := do
  let input := mkInputContext source "Submission.lean"
  let (imports, state, headerEnd) ← plainHeader input allowed
  enableInitializersExecution
  let opts := maxHeartbeats.set {} 0
  let env ← importModules imports opts (loadExts := true)
  let context ← elaborateContext env preamble opts
  return (headerEnd, ← checkedProofOffset input (parserContext context) state expectedName)

end Golfcheck
