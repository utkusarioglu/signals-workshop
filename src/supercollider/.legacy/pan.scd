s.boot;

s.waitForBoot({
  SynthDef(\panner, { |out| 
    var sig0, sig1;
    var freq1 = 500;
    var freq2 = 1000;
    // sig0 = Pan2.ar(Pulse.ar(freq1), Pulse.kr(0.5, 0.5));
    // sig1 = Pan2.ar(Pulse.ar(freq2), Pulse.kr(0.5, 0.5));
    sig0 = PinkNoise.ar(0.2) + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2);
    // sig = Pan2.ar(PinkNoise.ar(0.2), SinOsc.kr(0.5));
    Out.ar(0, sig0);
    // Out.ar(1, sig1);
  }).add;
  s.sync();

  a = Synth(\panner);
})
