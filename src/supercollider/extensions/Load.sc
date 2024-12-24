Load {
  // classvar workingAbsPath;

  // *initClass {
  //   workingAbsPath = File.getcwd;
  // }

  // *setRelPath { | relPath |
  //   workingAbsPath = workingAbsPath
  //     .addAll(relPath.split($/))
  //     .reduce('+/+');
  // }
  
  // *fixExtension{ | fileAbsPath |
  //   if(fileAbsPath.endsWith(".scd").not, {
  //     ^(fileAbsPath ++ ".scd");
  //   });
  //   ^fileAbsPath
  // }

  *scd { | fileRelpath |
    // var fileAbsPath;

    // fileAbsPath = [workingAbsPath]
    //   .addAll(fileRelpath.split($/))
    //   .reduce('+/+');
    // fileAbsPath = this.fixExtension(fileAbsPath);
    var fileAbsPath = Path.resolve(fileRelpath);
    fileAbsPath = Path.withExtension(fileAbsPath);
    ("Loaded:" + fileAbsPath).postln;

    ^(fileAbsPath.load);
  }

  *temp { | tempName |
    // var fileAbsPath;

    // fileAbsPath = [workingAbsPath, "temp"]
    //   .addAll(tempName.split($/))
    //   .reduce('+/+');
    // fileAbsPath = this.fixExtension(fileAbsPath);
    
    var fileAbsPath = Path.resolve("temp" ++ tempName);
    fileAbsPath = Path.withExtension(fileAbsPath);

    ^(fileAbsPath.load);
  }
}
