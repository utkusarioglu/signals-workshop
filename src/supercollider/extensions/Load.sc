Load {
  *scd { | fileRelpath |
    var fileAbsPath = Path.resolve(fileRelpath);
    fileAbsPath = Path.withExtension(fileAbsPath);
    ("Loaded:" + fileAbsPath).postln;

    ^(fileAbsPath.load);
  }

  *temp { | tempName |
    var fileAbsPath = Path.resolve(["temp", tempName].reduce('+/+'));
    fileAbsPath = Path.withExtension(fileAbsPath);

    ^(fileAbsPath.load);
  }
}
