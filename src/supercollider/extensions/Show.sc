Show {
  classvar server;
  
  *controlScope { | key |
    Config.loadFromSpecs;
    Client.setup(Config.getHost, Config.getPort).doWhenBooted({ 
      Server.default.scope(
        numChannels: Config.getBusLength(key),
        index: Config.getBusIndexStart(key),
        rate: "control"
      );
    });
  }
}
