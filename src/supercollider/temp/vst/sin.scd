{
  SynthDef(\white, { 
    var sig = WhiteNoise.ar();
    Out.ar(10, sig);
  }).add;
}.()
