o = ServerOptions.new;
o.protocol_(\tcp);
s = Server.remote(\remote, NetAddr("localhost", 57110), o); // set to correct address and port
s.addr.connect;
Server.default = s;

s.doWhenBooted({ 
  var synthDefs, portFile;
  var reverbBusses;
  var p, q;

  portFile = File(File.getcwd ++ "/.lang_port", "w+");
  portFile.write("" ++ NetAddr.langPort);
  portFile.close;

  reverbBusses = Bus.control(s, 8);
  reverbBusses.set(1, 0.5, 0.5, 0, 1, 0, 0, 0);

  ("reverbBusses:" + reverbBusses.index).postln;
  s.freeAll;

  synthDefs = {
    SynthDef(\FreeVerb2x2, { 
      |
        out,
        in,
        reverbCf
      |
      var inSig, outSig, krs, mix, room, damp, amp, lpf, hpf;

      krs = In.kr(reverbCf, 8);
      amp = krs[0].linlin(0, 1, 0, 2).lag(0.1);
      room = krs[1].lag(0.1);
      damp = krs[2].lag(0.1);
      mix = krs[3].lag(0.1);
      lpf = krs[4].linexp(0, 1, 20, 20000).lag(0.1);
      hpf = krs[5].linexp(0, 1, 20, 20000).lag(0.1);

      inSig = In.ar(in, 1);
      inSig = LPF.ar(inSig, lpf);
      inSig = HPF.ar(inSig, hpf);
      inSig = inSig ! 2;

      outSig = FreeVerb2.ar( 
          inSig[0], 
          inSig[1], 
          mix, room, damp, amp
      );

      Out.ar(out, outSig);
    }).add;

    "synthdefs registered".postln;
  };

  OSCdef(\reverb, {
    arg msg;

    reverbBusses.setAt(msg[1], msg[2]);
  }, "/reverb");

  synthDefs.();

  wait(1);

  (
    instrument: \FreeVerb2x2,
    reverbCf: reverbBusses,
    out: 0,
    in: 2,
  ).play;

  "ready".postln;
});
