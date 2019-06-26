import os
import parsecfg

# create a new repo with initial files
proc createRepo*(path: string) =

  if existsFile(path):
    echo "File exists! Cannot create repo."
    return

  if existsDir(path):
    # can't check if iterator is empty as we can use it only in a for
    for kind, path in path.walkDir:
      echo "Folder is not empty. Cannot create repo."
      return

  let gitdir = path/".git"

  path.createDir
  createDir gitdir
  createDir gitdir/"objects"
  createDir gitdir/"refs"
  createDir gitdir/"refs"/"heads"
  createDir gitdir/"refs"/"tags"

  (gitdir/"description").writeFile "unnamed repo; edit this file to name this repo\n"
  (gitdir/"HEAD").writeFile "ref: refs/heads/master\n"

  var repoconfig = newConfig()
  repoconfig.setSectionKey "core", "repositoryformatversion", "0"
  repoconfig.setSectionKey "core", "filemode", "false"
  repoconfig.setSectionKey "core", "bare", "false"
  repoconfig.writeConfig gitdir/"config"

  echo "Initialized empty Git repository in " & gitpath.absolutePath
