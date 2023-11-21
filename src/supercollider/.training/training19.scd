o = ServerOptions.new;
o.protocol_(\tcp);
s = Server.remote(\remote, NetAddr("localhost", 57110), o); // set to correct address and port
s.addr.connect;
// s.clientID = 3;
s.startAliveThread( 0 );
Server.default = s;

s.doWhenBooted({ 
  var synthDefs, music;

  s.freeAll;

  synthDefs = {
    SynthDef(\saw2, {
      arg freq, amp, out;
      var sig;

      sig = SinOsc.ar(freq) * amp;

      Out.ar(out, sig); 
    }).add;
    // "synthdef registered".postln;
  };

  music = {
    (
      \instrument: \saw2,
      \out: 0,
      \freq: 400,
      \amp: 1
    ).play();
  };

  synthDefs.();
  // music.();
});
