import LeanGolf.Source
import LeanGolf.Verify
import LeanGolf.Batch

open Lean Golfcheck

-- The Lean shell uses the same runtime limit for its -M flag.
@[extern "lean_internal_set_max_memory"]
private opaque setMemoryLimit (bytes : USize) : BaseIO Unit

private def memoryLimit : USize := 6 * 1024 * 1024 * 1024

private def reject (reason : String) : IO UInt32 := do
  IO.println <| (Json.mkObj [
    ("valid", toJson false), ("score", .null), ("statement_hash", toJson ""),
    ("axioms", toJson (#[] : Array String)), ("reason", toJson reason)]).compress
  return 1

unsafe def main (args : List String) : IO UInt32 := do
  try
    match args with
    | "--parse" :: file :: name :: preambleFile :: allowed =>
      setMemoryLimit memoryLimit
      initSearchPath (← findSysroot)
      let (header, proof) ← proofLayout (← IO.FS.readFile file) name
        (← IO.FS.readFile preambleFile) allowed
      IO.println (toJson (#[header, proof] : Array Nat)).compress
      return 0
    | "--fingerprint" :: reference :: draft :: name :: allowed =>
      setMemoryLimit memoryLimit
      initSearchPath (← findSysroot)
      let fingerprint ← fingerprintStatement reference draft name.toName allowed
      IO.println (toJson fingerprint).compress
      return 0
    | ["--statement-batch", job] =>
      setMemoryLimit memoryLimit
      initSearchPath (← findSysroot)
      fingerprintBatch job
      return 0
    | "--verify" :: reference :: submission :: name :: policyFile :: [] =>
      setMemoryLimit memoryLimit
      initSearchPath (← findSysroot)
      let policy ← IO.FS.readFile policyFile
      let .ok policy := Json.parse policy | throw <| IO.userError "invalid theorem metadata"
      let .ok (forbidden : List String) := policy.getObjValAs? (List String) "forbidden"
        | throw <| IO.userError "invalid forbidden list"
      let .ok (allowed : List String) := policy.getObjValAs? (List String) "imports"
        | throw <| IO.userError "invalid import list"
      let result ← verify reference submission name.toName forbidden allowed
      IO.println result.compress
      return 0
    | ["--statement", theoremDir] =>
      let child ← IO.Process.spawn {
        cmd := "python3"
        args := #["-I", "scripts/check_source.py", (← IO.appPath).toString, "--statement", theoremDir]
      }
      return ← child.wait
    | [theoremDir, file] =>
      let child ← IO.Process.spawn {
        cmd := "python3"
        args := #["-I", "scripts/check_source.py", (← IO.appPath).toString, theoremDir, file]
      }
      return ← child.wait
    | _ => reject "usage: lake exe golfcheck THEOREM_DIR FILE.lean, or --statement THEOREM_DIR"
  catch e =>
    reject e.toString
