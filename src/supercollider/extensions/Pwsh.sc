Pwsh {
  *sync { | command |
    var p, l, lines;
    p = Pipe.argv([
      "powershell",
      "-Command",
      command.quote,
    ], "r"); 
    while { l = p.getLine; l.notNil } {
      lines = lines.add(l);
    };
    p.close;
    ^lines;
  }

  *async { | command, args |
    var p, pid, cmd, l, c;
    // cmd = "powershell -Command \"$proc = Start-Process -FilePath % -ArgumentList % -PassThru -RedirectStandardOutput % -RedirectStandardError %; $proc.Id\"".format(command, args, File.getcwd + "\\stdout.log", File.getcwd + "\\stderr.log");
    cmd = [
      "$proc",
      "=",
      "Start-Process", 
      "-FilePath",
      command,
      "-ArgumentList",
      args.quote.replace($", "'"),
      "-PassThru", 
      "-RedirectStandardOutput",
      "%/%".format(File.getcwd, "stdout.log"),
      "-RedirectStandardError",
      "%/%".format(File.getcwd, "stderr.log"),
      "-WindowStyle",
      "Hidden",
      ";",
      "$proc.Id",
      // "$proc = Start-Process -FilePath % -ArgumentList % -PassThru -RedirectStandardOutput % -RedirectStandardError %; $proc.Id".quote
    ].join(" ");
    cmd.postln;
    p = Pipe.argv([
      "pwsh",
      "-Command",
      cmd,
      // "% *> %\\%".format(command, File.getcwd, "pwsh.log").quote,
      // "powershell -Command \"$proc = Start-Process -FilePath % -ArgumentList '%' -PassThru -RedirectStandardOutput '%' -RedirectStandardError '%'; $proc.Id\"".format(command, args, File.getcwd + "\\stdout.log", File.getcwd + "\\stderr.log")
    ], "r"); 
    // c = 0;
    // while { l = p.getLine; l.notNil } {
    //   c = c + 1;
    //   if ( c < 10 ) {
    //     l.postln;
    //   }
    // };
    pid = p.getLine;
    p.close;
    ^pid;
  }
}
