{
  var p, l, lines;
  p = Pipe.argv([
    "powershell",
    "-Command",
    "\"Get-Date\""
  ], "r"); 
  l = p.getLine;
  while { l.notNil } { 
    l.isEmpty.not.if({
      lines = lines.add(l);
    });
    l = p.getLine;
  };
  lines.postln;
  p.close;
}.();
