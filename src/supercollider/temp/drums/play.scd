{
  Task {
    ~play.stop;
    0.5.wait;

    ~play = Ppar([
      Pbind(
        \type, \vst_midi,
        \vst, ~drums,
        \midinote, Pseq([36], inf),
        \dur, 0.125,
        \amp, Pseq(#[1, 0.8, 0.8, 0.8], inf)
      ),
      Pbind(
        \type, \vst_midi,
        \vst, ~drums,
        \midinote, Pseq([\rest, 38], inf),
        \dur, Prand(#[1], inf),
        \amp, Pexprand(1, inf)
      ),
      Pbind(
        \type, \vst_midi,
        \vst, ~drums,
        \midinote, Pseq([49, 49, 49, 52], inf),
        \dur, 0.5,
        \amp, Pexprand(1, inf)
      ),
    ])
    .play(quant: 1)
  }.start;
}.();
