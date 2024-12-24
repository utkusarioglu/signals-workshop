Json {
  *write { | obj, abspath, mode = "w" |
    File(abspath, mode).write(obj.asJSON).close;
  }

  *load { | absPath |
    var json = File.readAllString(absPath);
    ^JSONlib.convertToSC(json);
  }
}
