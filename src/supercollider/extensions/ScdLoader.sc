Load {
  classvar workingAbsPath;

  *setRelPath { | relPath |
    workingAbsPath = [
      File.getcwd,
      Platform.pathSeparator,
      relPath
    ].reduce('++');
  }

  *path { | fileRelpath |
    var fileAbsPath = [
      workingAbsPath, 
      Platform.pathSeparator,
      fileRelpath
    ].reduce('++');
    ^(fileAbsPath.load);
  }

  *temp { | tempName |
    var tempAbsPath = [
      workingAbsPath, 
      Platform.pathSeparator,
      "temp",
      Platform.pathSeparator,
      tempName,
      ".scd"
    ].reduce('++');
    ^(tempAbsPath.load);
  }
}
