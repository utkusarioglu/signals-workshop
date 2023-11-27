var define = { | cf, out |
  ScampUtils.instrumentFromSynthDef(
    SynthDef(\scamp1, { | 
        freq=440,
        volume=1,
        gate=1
      |
      var krs, 
        crackliness1, crackliness2, crackliness3, crackliness4, crackliness5,
        spread, pan, amp;
      var synth, sig, env, pan2;

      ("CF" + cf).postln;

      krs = In.kr(cf, 8);
      amp = krs[0].linlin(0, 1, 0, 1);
      crackliness1 = krs[1].linlin(0, 1, 30, 100);
      crackliness2 = krs[1].linlin(0, 1, 0, 0.2);
      crackliness3 = krs[1].linlin(0, 1, 1, 300);
      crackliness4 = krs[1].linexp(0, 1, 0.02, 0.01);
      crackliness5 = krs[1].linlin(0, 1, 0.2, 0.01);

      spread = krs[2].linlin(0, 1, 1.0, 0.8);
      pan = krs[3].linlin(0, 1, -1, 1);

      synth = Mix.fill(5, { |k|
        var spreadThreshold = 100;
        var lfNoise = LFNoise1.ar(crackliness1, crackliness2, 1);

        Pan2.ar(
          Saw.ar( freq * spread.pow(k - 2) * lfNoise, crackliness3
          ) * EnvGen.kr(Env.perc(
            attackTime: crackliness4,
            releaseTime: crackliness5
          ),
            gate: Impulse.kr(40)),
            k.linlin(0,5,-1, 1)
        )
      });

      env = EnvGen.ar(Env.adsr, gate: gate, doneAction: 2);
      pan2 = Pan2.ar(DC.ar(1), pan);
      sig = synth * pan2 * env * volume * amp;

      Out.ar(out, sig);
    })
  );
};

define;
