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
    var specsFile = File(File.getcwd ++ "/.scd_specs", "w+");
    specsFile.write(all.asJSON);
    specsFile.close;

    "Specs published".postln;
  }
}
