Client {
  *setup { |
    host = "localhost",
    port = 57110
    |
    var options, server;

    ["Establishing connection with ", host, ":", port, "…"].reduce('++').postln;

    options = ServerOptions.new;
    options.protocol_(\tcp);
    // options.protocol_(\udp);
    server = Server.remote(\remote, NetAddr(host, port), options); // set to correct address and port
    server.addr.connect;
    Server.default = server;

    ~rel = ["src", "supercollider"].reduce('+/+');
    ~abs = [File.getcwd, ~screl].reduce('+/+');
    ~temp = [~abs, "temp"].reduce('+/+');

    ^server;
  }

  *console {
    Client.setup;
    Load.setRelPath(~rel);
    Show.control(\guitar1);
  }
}
