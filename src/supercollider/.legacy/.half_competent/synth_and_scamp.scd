// This one receives osc signals from both the web server and scamp

o = ServerOptions.new;
o.protocol_(\tcp);
s = Server.remote(\remote, NetAddr("localhost", 57110), o); // set to correct address and port
s.addr.connect;
Server.default = s;

s.doWhenBooted({ 
  var synthDefs, createSpecsFile;
  var synthBusses, reverbBusses, synthDefaults, reverbDefaults;
  var routine, scdSpecs;

  synthDefaults = [0.8, 0, 0, 0, 0.01, 1, 0.1, 0.1];
  reverbDefaults = [0.3, 0.5, 0.5, 0.5, 0, 0, 0, 0];

  createSpecsFile = {
    arg specs;

    var portFile;

    portFile = File(File.getcwd ++ "/.scd_specs", "w+");
    portFile.write(specs.asJSON);
    portFile.close;
  };

  synthBusses = Bus.control(s, 8);
  synthBusses.setn(synthDefaults);

  reverbBusses = Bus.control(s, 8);
  reverbBusses.setn(reverbDefaults);

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
        envelope: Env.adsr(
          atk,
          dec,
          slev,
          rel
        ),
        gate: gate,
        doneAction: Done.freeSelf,
      );

      sinSig = Pulse.ar([
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
      sig = sig ! 2;

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

  OSCdef(\melody, {
    arg msg;
    var sequence, speed, tempo, root, repeat;

    sequence = msg;
    sequence.removeAt(0);
    tempo = sequence.removeAt(0);
    speed = sequence.removeAt(0);
    root = sequence.removeAt(0);
    repeat = sequence.removeAt(0);

    TempoClock.tempo = tempo / 60;

    (
      "Tempo:" + tempo + 
      "Speed:" + speed + 
      "Root:" + root + 
      "Repeat" + repeat + 
      "Length:" + sequence.size
    ).postln;

    routine.stop;
    routine = Routine({
      repeat.do({
        sequence.do({
          arg value;

          (
            \instrument: \saw3,
            \midinote: root + value,
            \out: 3,
            \synthCf: synthBusses,
            \spreadThreshold: 100,
          ).play;

          yield(speed);
        });
      });
    });
    routine.play;
  }, "/melody");

  scdSpecs = (
    \langPort: NetAddr.langPort, 
    \synth: synthDefaults, 
    \reverb: reverbDefaults
  );

  createSpecsFile.(scdSpecs);

  "Ready".postln;
});
