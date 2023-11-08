o = ServerOptions.new;
o.protocol_(\tcp);
s = Server.remote(\remote, NetAddr("localhost", 57110), o); // set to correct address and port
s.addr.connect;
Server.default = s;

s.doWhenBooted({ 
  var synthDefs;
  var ampBus, spreadBus;
  "starting".postln;

  ampBus = Bus.control(s, 1);
  spreadBus = Bus.control(s, 1);


  ("ampBus index:" + ampBus.index).postln;
  ("spreadBus index: " + spreadBus.index).postln;
  // s.freeAll;

  synthDefs = {
    SynthDef(\saw3, {
      arg freq, out, ampCf, spreadCf, spreadThreshold;
      var sig, amp, spread;
      
      amp = In.kr(ampCf, 1);
      spread = In.kr(spreadCf, 1);
      sig = SinOsc.ar([
        freq, 
        freq + (spread * spreadThreshold),
        freq + (spread * spreadThreshold * 2),
        freq + (spread * spreadThreshold * 4),
      ]) * amp;
      sig = sig.sum / 4;

      Out.ar(out, sig); 
    }).add;
    "synthdef registered".postln;
  };
  
  NetAddr.langPort.postln;

  OSCdef(\synth, {
    arg msg;

    msg.postln;
    switch(msg[1],
      0, {
        var exponentiated = msg[2].linexp(0, 127, 1, 2) - 1;
        ("ampBus" + exponentiated).postln;
        ampBus.set(exponentiated);
      },
      1, {
        var normalized = msg[2].linlin(0, 127, 0, 1);
        ("spreadBus" + normalized).postln;
        spreadBus.set(normalized);
      },
      {"unrecognized".postln;});

  }, "/synth");

  synthDefs.();

  wait(1);

  (
    instrument: \saw3,
    freq: 400,
    ampCf: ampBus,
    spreadCf: spreadBus,
    spreadThreshold: 10,
    out: 0,
  ).play;

  "ready".postln;
});
