Load {
  classvar workingAbsPath;

  *setRelPath { | relPath |
    workingAbsPath = [
      File.getcwd,
      Platform.pathSeparator,
      relPath
    ].reduce('++');
  }

  *scd { | fileRelpath |
    var fileAbsPath = [
      workingAbsPath, 
      Platform.pathSeparator,
      fileRelpath,
      ".scd"
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
