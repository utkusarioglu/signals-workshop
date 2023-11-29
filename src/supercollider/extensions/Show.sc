Show {
  classvar server;
  
  *controlScope { | key |
    Runtime.loadFromSpecs;
    Client.setup(Runtime.getHost, Runtime.getPort).doWhenBooted({ 
      Server.default.scope(
        numChannels: Runtime.getBusLength(key),
        index: Runtime.getBusIndexStart(key),
        rate: 'control'
      );
    });
  }

  *audioScope {
    Runtime.loadFromSpecs;
    Client.setup(Runtime.getHost, Runtime.getPort).doWhenBooted({ 
      Server.default.scope(
        numChannels: 5,
        index: 0,
        rate: 'audio'
      );
    });
  }
}
