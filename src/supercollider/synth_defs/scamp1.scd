ScampUtils.instrumentFromSynthDef(
  SynthDef(\scamp1, { | freq=440, volume=0, gate=1, crackliness=0, spread=0, pan=0 |
    var synth = Mix.fill(5, { |k| 
      Pan2.ar(
        Saw.ar(
          freq * spread.linlin(0, 1, 1.0, 0.8).pow(k-2) * LFNoise1.ar(
            crackliness.linlin(0, 1, 30, 100), 
            crackliness.linlin(0, 1, 0, 0.2), 
            1
          ),
          crackliness.linlin(0, 1, 1, 300)
        ) * EnvGen.kr(Env.perc(
          attackTime: crackliness.linexp(0, 1, 0.02, 0.01),
          releaseTime: crackliness.linlin(0, 1, 0.2, 0.01)
        ),
          gate: Impulse.kr(40)),
          k.linlin(0,5,-1, 1)
      )
    });
    var panned_out = volume * synth * EnvGen.ar(Env.adsr, gate: gate, doneAction: 2) * Pan2.ar(DC.ar(1), pan);
    Out.ar(0, panned_out);
  })
);
