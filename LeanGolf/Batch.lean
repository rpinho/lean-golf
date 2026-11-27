import LeanGolf.Source
import LeanGolf.Verify

namespace Golfcheck
open Lean Parser

private structure PacketInput where
  name : String
  allowed : List String
  reference : String
  template : String
  preamble : String
  deriving FromJson

/-- Trusted authoring only. Reuse the last pinned import environment while
    elaborating each packet in its own command state. Replay each resulting
    certificate from that original environment. -/
unsafe def fingerprintBatch (job : System.FilePath) : IO Unit := do
  let file ← IO.FS.Handle.mk job .read
  let out ← IO.getStdout
  let mut cached : Option (Array Import × Environment) := none
  repeat
    let line ← file.getLine
    if line.isEmpty then break
    let result ← try
      let .ok (item : PacketInput) := Json.parse line >>= fromJson?
        | throw <| IO.userError "invalid batch packet"
      let reference := mkInputContext item.reference "GolfReference.lean"
      let (imports, start, _) ← plainHeader reference item.allowed
      let opts := maxHeartbeats.set {} 0
      let env ← match cached with
        | some (key, env) => do
          unless key == imports do
            throw <| IO.userError "a batch must use the same imports for every packet"
          pure env
        | none => do
          enableInitializersExecution
          importModules imports opts (loadExts := true)
      cached := some (imports, env)
      let compiled ← Elab.IO.processCommands reference start
        (Elab.Command.mkState (env.setMainModule `GolfReference) {} opts)
      try
        checkSyntaxErrors compiled.commandState.messages
      catch e =>
        throw <| IO.userError s!"reference compilation failed: {e}"
      let template := mkInputContext item.template "Submission.lean"
      let (templateImports, templateStart, headerEnd) ← plainHeader template item.allowed
      unless templateImports == imports do
        throw <| IO.userError "statement template imports differ from reference"
      let context ← elaborateContext env item.preamble opts
      let proofEnd ← try
        checkedProofOffset template (parserContext context) templateStart item.name
      catch e =>
        throw <| IO.userError s!"source lint failed: {e}"
      let bytes := item.template.toUTF8
      let importsText := String.fromUTF8! (bytes.extract 0 headerEnd)
      let theoremText := String.fromUTF8! (bytes.extract headerEnd proofEnd)
      let draft := mkInputContext
        (importsText ++ "\n\n" ++ item.preamble ++ "\n\n" ++ theoremText.trimAsciiStart.toString
          ++ " by sorry\n") "GolfSubmission.lean"
      let (_, draftStart, _) ← plainHeader draft item.allowed
      let draftCompiled ← Elab.IO.processCommands draft draftStart
        (Elab.Command.mkState (env.setMainModule `GolfSubmission) {} opts)
      checkSyntaxErrors draftCompiled.commandState.messages
      let moduleData ← mkModuleData compiled.commandState.env
      let draftData ← mkModuleData draftCompiled.commandState.env
      let fingerprint ←
        fingerprintStatementData moduleData draftData item.name.toName item.allowed (some env)
      pure <| Json.mkObj [("fingerprint", toJson fingerprint)]
    catch e =>
      pure <| Json.mkObj [("reason", toJson e.toString)]
    out.putStrLn result.compress
    out.flush

end Golfcheck
