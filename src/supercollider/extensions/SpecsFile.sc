SpecsFile {
  classvar all;
  
  *initClass {
    all = ();
  }
  
  *includeKv { | key, value |
    var d = Dictionary();
    d.put(key, value);
    all = all ++ d;
  }

  *includeDict { | dict |
    all = all ++ dict;
  }

  *publish {
    var specsFileAbsPath = [
      File.getcwd,
      Platform.pathSeparator,
      ".scd_specs.json"
    ].reduce('++');
    var specsFile = File(specsFileAbsPath, "w+");
    specsFile.write(all.asJSON);
    specsFile.close;

    "Specs published.".postln;
  }
}
