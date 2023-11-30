SpecsFile {
  classvar all;
  classvar specsFileBase;
  
  *initClass {
    all = Dictionary();
    specsFileBase = "artifacts/scd_runtime.json";
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
    var specsFile = File(this.getSpecsFileAbsPath(), "w+");
    this.includeKv(\timestamp, Date.localtime.asString);

    specsFile.write(all.asJSON);
    specsFile.close;
  }

  *read {
    ^JsonLoader(specsFileBase).load;
  }

  *getSpecsFileAbsPath {
    var specsFileAbsPath = [
      File.getcwd,
      Platform.pathSeparator,
      specsFileBase
    ].reduce('++');
    ^specsFileAbsPath;
  }

  *log {
    ("Specs written to '" ++ specsFileBase ++ "'.").postln;
    [
      "Client connected to '", 
      all[\config][\connection][\host], 
      ":", 
      all[\config][\connection][\port], 
      "'."
    ].reduce('++').postln;
  }

  *checkIfExists {
    ^File.exists(this.getSpecsFileAbsPath());
  }
}
