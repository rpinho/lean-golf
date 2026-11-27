import LeanGolf.Source
import LeanGolf.Verify

open Lean Golfcheck

-- The Lean shell uses the same runtime limit for its -M flag.
@[extern "lean_internal_set_max_memory"]
private opaque setMemoryLimit (bytes : USize) : BaseIO Unit

private def reject (reason : String) : IO UInt32 := do
  IO.println <| (Json.mkObj [
    ("valid", toJson false), ("score", .null), ("statement_hash", toJson ""),
    ("axioms", toJson (#[] : Array String)), ("reason", toJson reason)]).compress
  return 1

unsafe def main (args : List String) : IO UInt32 := do
  try
    match args with
    | "--parse" :: file :: name :: allowed =>
      setMemoryLimit (2048 * 1024 * 1024)
      initSearchPath (← findSysroot)
      let offset ← proofOffset (← IO.FS.readFile file) name allowed
      IO.println (toJson offset).compress
      return 0
    | "--verify" :: reference :: submission :: name :: policyFile :: [] =>
      setMemoryLimit (2048 * 1024 * 1024)
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
    | [theoremDir, file] =>
      let child ← IO.Process.spawn {
        cmd := "python3"
        args := #["-I", "scripts/check_source.py", (← IO.appPath).toString, theoremDir, file]
      }
      return ← child.wait
    | _ => reject "usage: lake exe golfcheck theorems/<slug> FILE.lean"
  catch e =>
    reject e.toString
