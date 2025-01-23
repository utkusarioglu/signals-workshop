{
  SynthDef(\old, { | freq = #[3000, 200] | 
    // var freqs = freq.dup;
    var sig = freq.collect({ | f | SinOsc.ar(f) });
    Out.ar(0, sig);
  }).add;

  SynthDef(\new, { 
    var sig = \freq.ir(200.dup).collect({ | f | SinOsc.ar(f)});

    Out.ar(0, sig);
  }).add;
  
  Task {
    s.sync;

    [\old, \new].do({ | synth |
      0.1.wait;
      ~play = (
        \instrument: synth,
        \freq: #[300, 500]
      ).play;
      1.4.wait;
      ~play.free;
    });
  }.start;
}.();
