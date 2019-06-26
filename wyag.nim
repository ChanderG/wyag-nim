import commandeer
import wyaglib

commandline:
  subcommand init, "init":
    arguments path, string, false # we expect either nothing or a single path

if init:
  let repo =
    if path == []:
        "."
    else:
        path[0]
  wyaglib.createRepo(repo)
