SpecsFile {
  *write {
    arg specs;

    var portFile;

    portFile = File(File.getcwd ++ "/.scd_specs", "w+");
    portFile.write(specs.asJSON);
    portFile.close;
  }
}
