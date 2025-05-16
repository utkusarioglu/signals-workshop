{
  ~drums.isNil.not.if({ ~drums.close });
  // SynthDef(\drums).free;

  SynthDef(\drums, {
    Out.ar(0, VSTPlugin.ar(nil, 2, id: \drums));
  }).add;

  Task {
    s.sync;
    ~drums = VSTPluginController(Synth(\drums), id: \drums)
      .open(
        "Superior Drummer 3",
        editor: true,
        verbose: true,
        action: _.editor
      );
  }.start;
}.();
