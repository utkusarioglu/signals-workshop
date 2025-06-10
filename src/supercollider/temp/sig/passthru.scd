{
  ~passthru.isNil.not.if({ ~passthru.free; });
  Synth(\passthru).free;

  SynthDef(\passthru, {
    Out.ar(\out.ir, In.ar(\in.ir, 1));
  }).add;

  Task {
    s.sync;

    ~passthru = Synth(\passthru, [\in, 8, \out, 10]); 
  }.start;
}.();
