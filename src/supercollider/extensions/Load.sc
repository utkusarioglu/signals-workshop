Loader {
  var <>workingRelPath;

  *new { | workingRelPath |
    ^super.newCopyArgs(workingRelPath);
  }
  
  init { | workingRelPath |
    this.workingRelPath = workingRelPath;
  }

  load { | fileRelpath |
    var abspath = [
      File.getcwd, 
      Platform.pathSeparator,
      this.workingRelPath, 
      Platform.pathSeparator,
      fileRelpath
    ].reduce('++');

    ^(abspath.load);
  }
}
