// o = ServerOptions.new;
// o.inDevice = "ASIO : Focusrite USB ASIO";
// o.outDevice = "ASIO : Focusrite USB ASIO";
// s = Server.remote(\remote, NetAddr(192.168.1.151, 57110), o);

// s.waitForBoot {
  Task {
    s.sync;
    Load.temp("guitar/thu");
    s.sync;
    Load.temp("sig/passthru");
  }.start;
// }

// s.addr.connect;
