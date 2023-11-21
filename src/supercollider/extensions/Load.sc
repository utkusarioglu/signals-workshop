Loader {
  var <>workingRelPath;

  *new { | workingRelPath |
    ^super.newCopyArgs(workingRelPath);
  }
  
  init { | workingRelPath |
    this.workingRelPath = workingRelPath;
  }

  load { | fileRelpath |
    var separator = "/";
    var abspath = [
      File.getcwd, 
      separator, 
      this.workingRelPath, 
      separator, 
      fileRelpath
    ].reduce('++');

    ^(abspath.load);
  }
}
