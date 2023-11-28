JsonLoader {
  var <>jsonRelPath;

  *new { | jsonRelPath |
    ^super.newCopyArgs(jsonRelPath);
  }

  init { | jsonRelPath |
    this.jsonRelPath = jsonRelPath;
  }

  load {
    var abspath = [
      File.getcwd, 
      Platform.pathSeparator, 
      this.jsonRelPath
    ].reduce('++');
    var json = File.readAllString(abspath);
    ^JSONlib.convertToSC(json);
  }
}
