{
  var pipe;
  ~log = List.new;

  // pipe = Pipe.new("powershell -Command \"& {ping 127.0.0.1 -t}\"", "r");
  pipe = Pipe.argv([
    "powershell", 
    "-Command",
    "& {ping 127.0.0.1 -t}".quote,
  ], "r");

  Routine({
      var line;
      while { line = pipe.getLine; line.notNil} {
          ~log.add(line);
          line.postln;
      };
      pipe.close;
  }).play;
}.();
