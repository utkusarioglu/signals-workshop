Specs {
  classvar all;
  classvar sinkAbsPath;
  
  *initClass {
    all = Dictionary();
  }

  *setFile{ | absPath |
    sinkAbsPath = absPath;
  }
  
  *includeKv { | key, value |
    var d = Dictionary();
    d.put(key, value);
    all = all ++ d;
  }

  *includeDict { | dict |
    all = all ++ dict;
  }

  *write {
    var absPath = this.getSpecsFileAbsPath();

    ("Specs written to '" ++ absPath ++ "'.").postln;
    this.includeKv(\timestamp, Date.localtime.asString);
    Json.write(all.asJSON, absPath, "w+");
  }

  *read {
    var absPath = this.getSpecsFileAbsPath();
    ^Json.load(absPath);
  }

  *getSpecsFileAbsPath {
    if(sinkAbsPath.isNil, {
      Error("Specs.setFile hasn't been called").throw;
    });
    ^sinkAbsPath
  }


  *checkIfExists {
    ^File.exists(this.getSpecsFileAbsPath());
  }
}
