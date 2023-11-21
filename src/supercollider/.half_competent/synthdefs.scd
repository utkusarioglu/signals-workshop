o = ServerOptions.new;
o.protocol_(\tcp);
s = Server.remote(\remote, NetAddr("localhost", 57110), o); // set to correct address and port
s.addr.connect;
Server.default = s;

s.doWhenBooted({ 
  var synthDefs, portFile;
  var synthBusses, reverbBusses;
  var p, q;

  portFile = File(File.getcwd ++ "/.lang_port", "w+");
  portFile.write("" ++ NetAddr.langPort);
  portFile.close;

  synthBusses = Bus.control(s, 8);
  reverbBusses = Bus.control(s, 8);

  ("synthBusses:" + synthBusses.index).postln;
  ("reverbBusses:" + reverbBusses.index).postln;
  s.freeAll;

  synthDefs = {
    SynthDef(\saw3, {
      | 
        freq, 
        out, 
        synthCf, 
        spreadThreshold, 
        gate = 1
      |
      var 
        sig, krs, env,
        sinSig, sinAmp, sinSpread,
        sawSig, sawAmp, sawSpread,
        atk, dec, slev, rel
      ;
      
      krs = In.kr(synthCf, 8);
      sinAmp = krs[0].linexp(0, 1, 1, 2) - 1;
      sinSpread = krs[1].linexp(0, 1, 1, spreadThreshold) - 1;

      sawAmp = krs[2].linexp(0, 1, 1, 2) - 1;
      sawSpread = krs[3].linexp(0, 1, 1, spreadThreshold) - 1;

      atk = krs[4];
      dec = krs[5];
      slev = krs[6];
      rel = krs[7];

      env = EnvGen.kr(
        // envelope: Env(
        //   levels: [0, 1, 0.2, 0],
        //   times: [0.01, 0.03, 0.05, 1],
        //   curve: 1,
        //   releaseNode: 2,
        // ),
        envelope: Env.adsr(
          atk,
          dec,
          slev,
          rel
        ),
        gate: gate,
        doneAction: Done.freeSelf,
      );

      sinSig = SinOsc.ar([
        freq, 
        freq + (sinSpread),
        freq + (sinSpread * 2),
        freq + (sinSpread * 4),
      ]) * sinAmp;

      sawSig = Saw.ar([
        freq, 
        freq + (sawSpread),
        freq + (sawSpread * 2),
        freq + (sawSpread * 4),
      ]) * sawAmp;

      sinSig = sinSig.sum / 4;

      sig = sinSig + sawSig;
      sig = sig.sum / 2;

      sig = sig * env;

      Out.ar(out, sig); 
    }).add;

    SynthDef(\FreeVerb2x2, { 
      |
        out,
        in,
        reverbCf
      |
      var inSig, outSig, krs, mix, room, damp, amp;

      krs = In.kr(reverbCf, 8);
      mix = krs[0];
      room = krs[1];
      damp = krs[2];
      amp = krs[3];

      inSig = In.ar(in, 2);

      outSig = FreeVerb2.ar( 
          inSig[0], 
          inSig[1], 
          mix, room, damp, amp
      );

      Out.ar(out, outSig);
    }).add;

    "synthdefs registered".postln;
  };
  
  NetAddr.langPort.postln;

  OSCdef(\synth, {
    arg msg;

    // msg.postln;
    synthBusses.setAt(msg[1], msg[2]);
  }, "/synth");

  OSCdef(\reverb, {
    arg msg;

    // msg.postln;
    reverbBusses.setAt(msg[1], msg[2]);
  }, "/reverb");

  synthDefs.();

  wait(1);

  (
    instrument: \FreeVerb2x2,
    reverbCf: reverbBusses,
    out: 0,
    in: 3,
  ).play;

  p = Pbind(
      \instrument, \saw3,
      \midinote, Pseq([60, 62, 67, 69], 20),
      \out, 3,
      \synthCf, synthBusses,
      \spreadThreshold, 10
  );
  q = p.play;

  "ready".postln;
});