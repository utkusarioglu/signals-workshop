{
// SynthDef for white noise generator
SynthDef(\whiteNoise, {
    Out.ar(10, WhiteNoise.ar(0.5)); // Send white noise to channel 10
}).add;

// SynthDef for BLowShelf processing
(
SynthDef(\blowShelf, { | freq |
    var sig = In.ar(10);
    sig = sig * SinOsc.kr(freq);
    // var filtered = BHiShelf.ar(input, freq, rq, gain);
    Out.ar(0, sig.dup); 
}).add;
);

// Play the white noise

// Use Pbind to control the BLowShelf parameters
Pdef(\seq, Pbind(
  \instrument, \blowShelf,
  \freq, Pseq([1, 10], inf), // Random cutoff frequency
  // \gain, Pexprand(-10, 0, inf),   // Random gain in dB
  // \rq, Pexprand(0.1, 2.0, inf),    // Random resonance
  \dur, 1                        // Duration of each event
));

Routine({
  // 2.wait;
  // ( 
  //   instrument: \default, 
  //   freq: 200,
  // ).play;

  1.wait;
  // ~def = Pdef(\seq).play();
  Pbind(
    \instrument, \blowShelf,
    \freq, Pseq([1, 10], inf), // Random cutoff frequency
    // \gain, Pexprand(-10, 0, inf),   // Random gain in dB
    // \rq, Pexprand(0.1, 2.0, inf),    // Random resonance
    \dur, 1                        // Duration of each event
  ).play;

  1.wait;
  ~white = Synth(\whiteNoise);

  // 5.wait;
  // Pdef(\seq).set(\freq, 10);
}).play;

}.()
