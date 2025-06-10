Client {
  *initClass {
    // thisProcess.argv.postln;
  }

  *setup { |
    host = "localhost",
    port = 57110
    |
    var options, server;

    ["Establishing connection with ", host, ":", port, "…"].reduce('++').postln;

    options = ServerOptions.new;
    options.protocol_(\tcp);
    options.maxLogins = 32;
    options.inDevice = "ASIO : Focusrite USB ASIO";
    options.outDevice = "ASIO : Focusrite USB ASIO";
    // options.safetyClipThreshold = 1;

    server = Server.remote(\remote, NetAddr(host, port), options); 
    server.addr.connect;
    Server.default = server;
    
    ^server;
  }

  *console { | tempScript |
    var loadTemp = {
      if(tempScript.isNil.not, {
        Load.temp(tempScript);
      });
    };
      
    if(Server.default.addr.isConnected, {
      "Already connected.".postln;
      loadTemp.()
    }, {
      Client.setup.doWhenBooted({
        loadTemp.();
      });
    });
    // Load.setRelPath("src/supercollider");
    // Show.control(\guitar1);
  }

  *reset {
    Server.default.freeAll;              // Free all nodes
    Server.default.defaultGroup.release; // Release default group
    Buffer.freeAll(Server.default);      // Free all buffers
    Server.default.sendMsg("/d_freeAll"); // Clear all SynthDefs
  }
}
