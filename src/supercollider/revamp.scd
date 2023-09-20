// OSCFunc;

s.boot;

s.waitForBoot({
  NetAddr .langPort;
  OSCFunc.trace(hideStatusMsg: true);
//
// SynthDef("cloud", {
// 	arg panCenter=0, panWidth=0.3, freqCenter=640, freqVariation=0.1, gain=0.7;
// 	var grainPan = WhiteNoise.ar(panWidth, panCenter);
// 	var grainFreq = WhiteNoise.ar(freqVariation * freqCenter, freqCenter);
// 	var grainTrigger = Impulse.kr(20);
// 	var granulator = GrainSin.ar(2, grainTrigger, 0.06, grainFreq, grainPan);
// 	Out.ar(0, granulator * gain);
// }).play

  ScampUtils.instrumentFromSynthDef(
    SynthDef("cloud", {
      arg panCenter=0, panWidth=1, freq=640, freqVariation=0.001, volume=0.4, gate=0;
      var grainPan = WhiteNoise.ar(panWidth, panCenter);
      var grainFreq = WhiteNoise.ar(freqVariation * freq, freq);
      var grainTrigger = Impulse.kr(5);
      var granulator = GrainSin.ar(2, grainTrigger, 0.06, grainFreq, grainPan);
      var env = EnvGate(gate:gate, fadeTime:0.1);
      Out.ar(0, granulator * volume * env);
    })
  )
})
