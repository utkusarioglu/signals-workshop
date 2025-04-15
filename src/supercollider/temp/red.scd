{
  SynthDef(\red, { | freq |
    var freqs, sig;

    // freqs = \freq.ir();
    sig = SinOsc.ar(freq);
    // sig = freqs.collect(SinOsc.ar(_));

    Out.ar(0, sig);
  }).add;

  Task {
    s.sync;
    ~red = (
      \instrument: \red,
      \freq: #[400],
    ).play;
    3.wait;
    ~red.free;
  }.start;
}.();
