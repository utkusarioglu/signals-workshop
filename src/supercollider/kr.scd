s.boot;

s.waitForBoot({
  SynthDef("kr", {
    arg f1 = 400,
      f2 = 440;
    var ampOsc, sig;
    var freqs = [f1, f2];
    ampOsc = SinOsc.kr(1, 1.5pi, 0.5, 0.5);
    sig = SinOsc.ar(freqs, 0, ampOsc);
    Out.ar(0, sig);
  }).add;
  s.sync();
  
  a = Synth.new("kr", [\f1, 400, \f2, 700]);
  
})
