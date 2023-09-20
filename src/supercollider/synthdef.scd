s.boot;

s.waitForBoot({
  SynthDef.new(\one, { 
    arg freq = 440, 
        out = 0,
        vol = 1;
    var sig;
    sig = [SinOsc.ar(freq, 0, vol), SinOsc.ar(freq, 0, vol)];
    Out.ar(out, sig);
  }).add;
  s.sync(); 
  a = Synth.new(\one, [\freq, 30, \vol, 1]);
})
