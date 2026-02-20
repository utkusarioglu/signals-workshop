{
  ~bass.isNil.not.if({ ~bass.close });

  SynthDef(\bass, {
    Out.ar(0, VSTPlugin.ar(nil, 2, id: \bass));
  }).add;

  Task {
    s.sync;

    ~bass = VSTPluginController(Synth(\bass), id:\bass)
      .open(
        "EZbass",
        editor: true,
        verbose: true,
        action: _.editor
      );
  }.start;
}.();
