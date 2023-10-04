// if (! s.serverRunning) {
s.boot;
// }

s.waitForBoot({
  NetAddr .langPort;
  // OSCFunc.trace(hideStatusMsg: true);

  ScampUtils.instrumentFromSynthDef(
    SynthDef("phased", {
      arg 
        panCenter=0,
        panWidth=1,
        freq=640,
        freqVariation=0.001,
        volume=0.4,
        gate=0,
        tremoloFreq=10;

      // var grainPan = WhiteNoise.ar(panWidth, panCenter);
      // var grainFreq = WhiteNoise.ar(freqVariation * freq, freq);
      // var grainTrigger = Impulse.kr(5);
      // var granulator = GrainSin.ar(2, grainTrigger, 0.06, grainFreq, grainPan);
      var velocity = SinOsc.kr(tremoloFreq);
      var env = EnvGate(gate:gate, fadeTime:0.1);
      var osc = LFPar;
      var sinFreq = freq * 2;
      var sin = [osc.ar(sinFreq, 0, 0.2), osc.ar(sinFreq * 1, 0.5 * pi, 0.2)];
      Out.ar(0, sin * velocity * env);
    });
  );

  ScampUtils.instrumentFromSynthDef(
    SynthDef("mono", {
      arg 
        fadeTime=0.1,
        panCenter=0, 
        panWidth=1, 
        freq=640, 
        freqVariation=0.001, 
        volume=0.4, 
        gate=0;

      // var grainPan = WhiteNoise.ar(panWidth, panCenter);
      // var grainFreq = WhiteNoise.ar(freqVariation * freq, freq);
      // var grainTrigger = Impulse.kr(5);
      // var granulator = GrainSin.ar(2, grainTrigger, 0.06, grainFreq, grainPan);
      var env = EnvGate(gate:gate, fadeTime:0.5);
      var sinFreq = freq;
      var osc = LFPar;
      var sin = [osc.ar(sinFreq, 0.1 * pi , 0.8), osc.ar(sinFreq, 0, 0.8)];
      Out.ar(0, sin * volume * env);
    });
  );

  ScampUtils.instrumentFromSynthDef(
    SynthDef("course", {
      arg 
        freq=640, 
        volume=0.4, 
        gate=0,
        drift,
        fadeTime;

      var env = EnvGate(gate:gate, fadeTime:fadeTime);
      var oscilator = LFPar;
      var sound1 = oscilator.ar(freq, [0, 0.1 * pi], 0.5);
      var sound2 = oscilator.ar(freq + drift, [0.1 * pi, 1], 0.5);
      var sound = sound1 + sound2;

      Out.ar(0, sound * volume * env);
    });
  );
})
