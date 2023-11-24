Client {
  *setup { | 
    host = "localhost", 
    port = 57110
    |
    var options, server;

    options = ServerOptions.new;
    options.protocol_(\tcp);
    server = Server.remote(\remote, NetAddr(host, port), options); // set to correct address and port
    server.addr.connect;
    Server.default = server;

    ["Client connected to '", host, ":", port, "'."].reduce('++').postln;
  }
}
