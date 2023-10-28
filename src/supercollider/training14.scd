s.boot;

s.newBusAllocators;

s.scope;

s.waitForBoot({
  var synthDefs, music, tempo, reverb;

  tempo = TempoClock(100/60);

  synthDefs = {
    SynthDef(\pulse, {
      var sig, env, freq, cf, harm, width, atk, rel, pan, amp, out;

      freq = \freq.kr(100);
      harm = \harm.ir(4);
      width = \width.ir(0.5);
      atk = \atk.ir(0.02);
      rel = \rel.ir(0.5);
      pan = \pan.kr(0);
      amp = \amp.kr(0.2);
      out = \out.kr(0);

      freq = freq * { Rand(-0.1, 0.1).midiratio }.dup(4);
      cf = freq * harm;
      sig = Pulse.ar(freq, width).sum * 0.1;
      sig = LPF.ar(sig, cf.clip(20, 20000));
      env = Env.perc(atk, rel).kr(Done.freeSelf);
      sig = Pan2.ar(sig, pan, amp);
      sig = sig * env;

      Out.ar(out, sig);
    }).add;

    SynthDef(\reverb, {
      var sig;

      var in, out, mix;
      in = \in.kr(0);
      out = \out.kr(0);
      mix = \mix.kr(1);
      
      sig = In.ar(in, 2);
      sig = FreeVerb2.ar(sig[0], sig[1], mix, 0.99);

      Out.ar(out, sig);
    }).add;
  };
  
  music = {
    var p, q, reverbBus, rev, revRoutine;

    reverbBus = Bus.audio(s, 2);

    rev = Synth(\reverb, [in: reverbBus, out: 0]);

    revRoutine = Routine({
      var val;
      val = 0;
      inf.do({
        val = val + 1 % 2;
        rev.set(\mix, val);

        1.yield;
      })
    });

    p = Pbind(
      \instrument, \pulse,
      \midinote, Pwhite(40.0, 108.0),
      \dur, Pexprand(0.05, 0.5),
      \db, Pwhite(-25.0, -10.0),
      \rel, Pexprand(0.07, 0.3),
      \out, reverbBus
    );

    reverb.play;
    revRoutine.play;
    q = p.play;

    wait(10);
    q.stop;
  };

  synthDefs.();
  wait(1);
  music.();
});
