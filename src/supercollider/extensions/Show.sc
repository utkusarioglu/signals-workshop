Show {
  classvar server;
  
  *control { | key |
    Server.default.scope(
      numChannels: Runtime.getBusLength(key),
      index: Runtime.getBusIndexStart(key),
      rate: 'control'
    );
  }

  *audio {
    Server.default.scope(
      numChannels: 12,
      index: 0,
      rate: 'audio'
    );
  }
}
