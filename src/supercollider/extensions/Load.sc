Load {
  *abspath { |fileAbsPath| 
    ("Loaded:" + fileAbsPath).postln;
    ^(fileAbsPath.load);
  }

  *relpath { | fileRelpath |
    var fileAbsPath = Path.resolve(fileRelpath, checkIfExists: false);
    fileAbsPath = Path.withExtension(fileAbsPath);
    this.abspath.(fileAbsPath)
  }

  *temp { | tempName |
    var fileAbsPath = Path.resolve(
      ["temp", tempName].reduce('+/+'), 
      checkIfExists: false
    );
    fileAbsPath = Path.withExtension(fileAbsPath);

    ^(fileAbsPath.load);
  }

  *preset { | name |
    Load.relpath("temp" +/+ "preset" +/+ name);
  }
}
