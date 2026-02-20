{
  var runAsyncCmd = { | command |
    var p, pid, argv;

    argv = [
      "powershell",
      "-Command",
      [
        File.getcwd ++ "\\" ++ "Start-LongRun.ps1",
        "-Command",
        command.quote.replace(" ", "\\ "),
        "-WorkingDirectory",
        File.getcwd.quote
      ].join(" ")
    ];

    argv.do(_.postln);

    p = Pipe.argv(argv, "r");
    pid = p.getLine;
    p.close;
    pid;
  };

  var runCmd = { | command | 
    var p, argv, l, lines;

    argv = [
      "powershell",
      "-Command",
      command.quote
    ];
    p = Pipe.argv(argv, "r");
    while { l = p.getLine; l.notNil } {
      lines.add(l);
    };
    p.close;
    lines;
  };

  var main = {
    Task {
      runAsyncCmd.("docker -c u-Boulanger exec -it 'docker-signals-workshop-1' bash -c 'cd /utkusarioglu-com/workshops/signals-workshop && ./run.sh'").postln;

      // runCmd.("docker -c u-Boulanger exec -it 'docker-signals-workshop-1' bash -c 'cat %'".format(pid_abspath)).postln;

      // "waiting".postln;
      // 10.wait;
      // "wait done".postln;

      // runCmd.("docker -c u-Boulanger exec -it 'docker-signals-workshop-1' bash -c 'cat % | xargs kill'".format(pid_abspath)).postln;
    }.start;
  }.();
}.();
