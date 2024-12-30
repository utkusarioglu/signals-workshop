Load {
  *scd { | fileRelpath |
    var fileAbsPath = Path.resolve(fileRelpath, checkIfExists: false);
    fileAbsPath = Path.withExtension(fileAbsPath);
    ("Loaded:" + fileAbsPath).postln;

    ^(fileAbsPath.load);
  }

  *temp { | tempName |
    var fileAbsPath = Path.resolve(
      ["temp", tempName].reduce('+/+'), 
      checkIfExists: false
    );
    fileAbsPath = Path.withExtension(fileAbsPath);

    ^(fileAbsPath.load);
  }
}
