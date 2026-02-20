{
  var r;

  var runPsCommand = { | cmd |
    var p, l, lines, task;
    lines = List.new;
    task = Task {
      p = Pipe.argv([
        "powershell",
        "-Command",
        cmd.quote
      ], "r"); 
      while { l = p.getLine; l.notNil } {
        lines = lines.add(l);
      };
      p.close;
      // lines;
    }.start;
    [task, lines]
  };

  Task {
    r = runPsCommand.("& {ping 127.0.0.1 -t}");
    r.postln;
    5.wait;
    r.isRunning.postln;
    r[1].postln;
  }.start;
  // .select(_.isEmpty.not).do({ |v| v.postln; }); "";
}.();
