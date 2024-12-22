Client {
  classvar <>serverInstance;
  
  *setup { |
    host = "localhost",
    port = 57110
    |
    var options, server;

    ["Establishing connection with ", host, ":", port, "…"].reduce('++').postln;

    options = ServerOptions.new;
    options.protocol_(\tcp);
    options.inDevice = "ASIO : Focusrite USB ASIO";
    options.outDevice = "ASIO : Focusrite USB ASIO";

    server = Server.remote(\remote, NetAddr(host, port), options); 
    server.addr.connect;
    Server.default = server;

    ~rel = ["src", "supercollider"].reduce('+/+');
    ~abs = [File.getcwd, ~rel].reduce('+/+');
    ~temp = [~abs, "temp"].reduce('+/+');
    
    serverInstance = server;
    
    ^server;
  }

  *console {
    Client.setup;
    Load.setRelPath(~rel);
    // Show.control(\guitar1);
  }

  *reset {
    serverInstance.freeAll;              // Free all nodes
    serverInstance.defaultGroup.release; // Release default group
    Buffer.freeAll(serverInstance);      // Free all buffers
    serverInstance.sendMsg("/d_freeAll"); // Clear all SynthDefs
  }
}
