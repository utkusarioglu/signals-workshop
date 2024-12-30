Path {
  const maxRepoRootDepth = 10;
  
  *resolve { | path, cwd, checkIfExists = true |
    var upCount = path.findAll("../").size;
    var relpath = path.replace("../", "").split($/).reduce('+/+');

    if(cwd.isNil, {
      cwd = File.getcwd;
    });
    
    upCount.do({
      cwd = PathName(cwd).parentPath;
    });

    path = [cwd, relpath].reduce('+/+');
    
    if(checkIfExists && File.exists(path).not, {
      Error("Resolved path % does not exist".format(path)).throw;
    });

    ^path
  }

  *repoRoot { 
    var cwd = File.getcwd;
    var found = false;
    maxRepoRootDepth.do({
      if(File.exists([cwd, ".git"].reduce('+/+')), {
        found = true;
      }, {
        cwd = PathName(cwd).parentPath;
      });
    });
    if(found.not, {
      Error(
        "Cannot reach repo root after % climbs"
          .format(maxRepoRootDepth)
      ).throw;
    });

    ^cwd;
  }

  *fromRepoRoot { | relpath, checkIfExists = true |
    var repoRoot = Path.repoRoot;
    var path = Path.resolve(relpath, repoRoot);
    
    if(checkIfExists && File.exists(path).not, {
      Error("Repo root path % does not exist".format(path)).throw;
    });

    ^path;
  }

  *withExtension { | path, ext = "scd", checkIfExists = true | 
    if(path.endsWith("." ++ ext).not, {
      path = (path ++ "." ++ ext);
    });

    if(checkIfExists && File.exists(path).not, {
      Error("Path with extension % does not exist".format(path)).throw;
    });

    ^path;
  }
}
