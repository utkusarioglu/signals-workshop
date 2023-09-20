s.boot;

s.waitForBoot({
  SynthDef(\help_notRand, { |out|
      var sig1, sig2, freq1 = 400, freq2 = 200;
      var osc1 = Pulse.kr(20);
      // var osc2 = Pulse.kr(1);
      freq1 = freq1 * osc1;
      // freq2 = freq2 * osc2;
      sig1 = Pulse.ar([freq1, freq2], 0.5, 0.5);
      // sig2 = Pulse.ar(freq2, 0.5, 0.1);
      // sig1 = FreeVerb.ar(sig1, 0.7, 0.5, 0.25);
      Out.ar(0, sig1);
      // Out.ar(1, sig2);
  }).add;
  s.sync();

  a = Synth(\help_notRand);
})
