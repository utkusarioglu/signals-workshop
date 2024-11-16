Client {
  *setup { |
    host = "localhost",
    port = 57110
    |
    var options, server;

    ["Establishing connection with ", host, ":", port, "…"].reduce('++').postln;

    options = ServerOptions.new;
    options.protocol_(\tcp);
    server = Server.remote(\remote, NetAddr(host, port), options); // set to correct address and port
    server.addr.connect;
    Server.default = server;

    ^server;
  }

  *console {
    Client.setup;
    Load.setRelPath("src/supercollider");
    Show.control(\guitar1);
  }
}
