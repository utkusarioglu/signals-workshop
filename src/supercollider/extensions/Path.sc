Path {
  const maxRepoRootDepth = 10;
  
  *resolve { | path, cwd |
    var upCount = path.findAll("../").size;
    var relpath = path.replace("../", "").split($/).reduce('+/+');

    if(cwd.isNil, {
      cwd = File.getcwd;
    });
    
    upCount.do({
      cwd = PathName(cwd).parentPath;
    });
    ^[cwd, relpath].reduce('+/+');
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
      Error("Cannot reach repo root").throw;
    });

    ^cwd;
  }

  *fromRepoRoot { | relpath |
    var repoRoot = Path.repoRoot;
    ^Path.resolve(relpath, repoRoot);
  }

  *withExtension { | path, ext = "scd" | 
    if(path.endsWith("." ++ ext).not, {
      ^(path ++ "." ++ ext);
    });
    ^path
  }
}
