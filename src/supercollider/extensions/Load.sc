Load {
  classvar workingAbsPath;

  *setRelPath { | ...relPath |
    workingAbsPath = [File.getcwd].addAll(relPath).reduce('+/+');
  }
  
  *fixExtension{ | fileAbsPath | 
    if(fileAbsPath.endsWith(".scd").not, {
      ^(fileAbsPath ++ ".scd");
    });
    ^fileAbsPath
  }

  *scd { | ...fileRelpath |
    var fileAbsPath;

    fileAbsPath = [workingAbsPath].addAll(fileRelpath).reduce('+/+');
    fileAbsPath = this.fixExtension(fileAbsPath);
    ("Loaded:" + fileAbsPath).postln;

    ^(fileAbsPath.load);
  }

  *temp { | ...tempName |
    var fileAbsPath;

    fileAbsPath = [workingAbsPath, "temp"].addAll(tempName).reduce('+/+');
    fileAbsPath = this.fixExtension(fileAbsPath);

    ^(fileAbsPath.load);
  }
}
