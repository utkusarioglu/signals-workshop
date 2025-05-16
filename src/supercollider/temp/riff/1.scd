~riff.isNil.not.if({ ~riff.stop; });

TempoClock.tempo_(1.5);

~riff = Ppar([
  // Pbind(
  //   \type, \vst_set,
  //   \vst, ~thu,
  //   \params, [1, 2],
  //   1, Pseq(Scale.majorPentatonic.degrees.reverse.normalize, inf),
  //   2, Pseq(Scale.major.degrees.normalize, inf),
  // ),
  Pbind(
    \type, \vst_midi,
    \vst, ~drums,
    \midinote, Pseq([38, \rest], inf),
    \amp, Pseq([0.6, 0.1, 0.2], inf),
    \dur, 0.125,
  ),
  Pbind(
    \type, \vst_midi,
    \vst, ~drums,
    \midinote, Pseq([\rest, 36], inf),
    \amp, Prand([0.8], inf),
  ),
  // Pbind(
  //   \type, \vst_midi,
  //   \vst, ~drums,
  //   \midinote, Pseq([\rest, 42], inf),
  //   \amp, Prand([0.8], inf),
  //   \dur, 0.125,
  // ),
  Pbind(
    \type, \vst_midi,
    \vst, ~drums,
    \midinote, Pseq([49], inf),
    \amp, 0.8,
    \dur, 16,
  ),
  // Pbind(
  //   \type, \vst_midi,
  //   \vst, ~bass,
  //   \midinote, Pseq(Scale.majorPentatonic.degrees.collect(_ + 38).scramble.stutter(8), inf),
  //   \amp, Pseq([0.5, 0.8], inf),
  //   \dur, 0.25,
  // ),
]).play;
