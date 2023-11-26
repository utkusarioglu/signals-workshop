s.boot;

s.meter;

s.waitForBoot({
  var synthDefs, music, tempo;

  tempo = TempoClock(100/60);

  synthDefs = {
    SynthDef(\thing, {
      arg 
        freq,
        amp,
        gate = 1,
        pan = 0,
        harm = 4,
        width = 5,
        atk = 0.02,
        dec = 0.3,
        slev = 0.3,
        rel = 1
        ;
      var sig, env, cf;

      freq = freq * { Rand(-0.1, 0.1).midiratio; }.dup(4);
      cf = freq * harm;

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

      sig = Pulse.ar(freq, width).sum / 4;
      sig = LPF.ar(sig, cf.clip(20, 20000));
      sig = sig * env;
      sig = Pan2.ar(sig, pan, amp);

      Out.ar(0, sig);
    }).add;
  };

  music = {
    var p, q;

    p = Pbind(
      \instrument, \thing,
      // \dur, Pexprand(0.1, 0.3, inf),
      \sustain, Pwhite(3.0, 6.0, inf),

      // \freq, Pwhite(1, 16, inf) * Prand([48, 55], inf),
      \degree, Pseq([0, 3, 5, 7], inf),
      // \note, Pseq([0, 1, 2,3], inf),
      // \midinote, Pseq([0, 1, 2,3] + 60, inf),
      \dur, Pseq([1/2, 1/4, 1/4, 1], inf),

      \harm, Pexprand(1, 10),
      \width, Pexprand(0.05, 0.7, inf),
      \pan, Pmeanrand(-1, 1, inf),
      \atk, 0.01,
      \dev, 0.08,
      \slev, 0,
      \rel, 0,

      // \amp, Pkey(\freq).linlin(48, 16*55, 0.5, 0.1),
      \db, Pseq([0, -4, -8, -12], inf),
    );

    "Starting…".postln;
    q = p.play(tempo);
    wait(5);
    q.stop;
    "Finishing…".postln;
  };
  
  synthDefs.();
  wait(1);
  music.();
});