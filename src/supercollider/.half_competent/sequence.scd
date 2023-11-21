o = ServerOptions.new;
o.protocol_(\tcp);
s = Server.remote(\remote, NetAddr("localhost", 57110), o); // set to correct address and port
s.addr.connect;
s.startAliveThread( 0 );
Server.default = s;

s.doWhenBooted({ 
  var music;

  s.freeAll;

  music = {
    (
      \instrument: \saw3,
      \out: 0,
      \freq: 100,
      \amp: 1
    ).play();
  };

  // music.();
});
