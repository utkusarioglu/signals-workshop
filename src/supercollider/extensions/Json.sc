Json {
  var <jsonAbsPath;

  // *new { | jsonAbsPath |
  //   ^super.newCopyArgs(jsonAbsPath);
  // }

  // init { | jsonAbsPath |
  //   this.jsonAbsPath = jsonAbsPath;
  // }

  *write { | obj, abspath, mode = "w" |
    // var f = File(abspath, "w+");
    // f.write(obj);
    // f.close;

    File(abspath, mode).write(obj.asJSON).close;
  }

  *load { | absPath |
    var json = File.readAllString(absPath);
    ^JSONlib.convertToSC(json);
  }
}
