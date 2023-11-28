ScdLoader {
  classvar workingAbsPath;

  *setRelPath { | relPath |
    workingAbsPath = [
      File.getcwd,
      Platform.pathSeparator,
      relPath
    ].reduce('++');
  }

  *load { | fileRelpath |
    var fileAbsPath = [
      workingAbsPath, 
      Platform.pathSeparator,
      fileRelpath
    ].reduce('++');
    ^(fileAbsPath.load);
  }
}
