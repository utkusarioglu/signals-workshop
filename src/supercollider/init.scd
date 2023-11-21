// This one receives osc signals from both the web server and scamp

o = ServerOptions.new;
o.protocol_(\tcp);
s = Server.remote(\remote, NetAddr("localhost", 57110), o); // set to correct address and port
s.addr.connect;
Server.default = s;

s.doWhenBooted({ 
  var workDir = File.getcwd ++ "/src/supercollider";
  var defaults = (workDir ++ "/defaults.scd").load;
  var busses = (workDir ++ "/busses.scd").load.(s, defaults);

  (workDir ++ "/synthdefs.scd").load.();
  (workDir ++ "/controldefs.scd").load.(busses);

  s.freeAll;

  (workDir ++ "/routinedefs.scd").load.(busses);

  SpecsFile.write(defaults ++ (
    \langPort: NetAddr.langPort, 
  ) );

  "Ready".postln;
});
