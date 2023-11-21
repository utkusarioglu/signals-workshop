s.boot;

s.waitForBoot({
  SynthDef(\mix, { |out| 
    var sig0, sig1;
    // a = [SinOsc.ar(440, 0, 0.2), Saw.ar(662, 0.2)];
    // b = [SinOsc.ar(442, 0, 0.2), Saw.ar(660, 0.2)];
    // sig0 = Mix([a, b]).postln;
    var n = 3;
    // sig0 = PinkNoise.ar(0.2) + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2);
    // sig1 = PinkNoise.ar(0.2) + SinOsc.ar(440, 0, 0.2) + Saw.ar(660, 0.2);
    sig0 = Mix.fill(n, { 
      arg index;
      var base = 500;
      var freq = base + (base * index);
      var amp = 1 / (index + 1) / n ;
      amp.postln;
      freq.postln;
      SinOsc.ar(freq, 0, amp); 
    });
    Out.ar(0, sig0);
    // Out.ar(1, sig1);
    sig0.scope();
    // sig1.scope();
  }).add;
  s.sync();
  a = Synth(\mix)
});
