{
  ~group.notNil.if({~group.free});
  ~drums.notNil.if({ ~drums.close });

  ~group = Group.new;

  ~drumsSynth = SynthDef(\drums, {
    Out.ar(0, VSTPlugin.ar(nil, 2, id: \drums));
  }).add;

  Task {
    s.sync;
    ~drumSynth = Synth(\drums, target: ~group);
    ~drums = VSTPluginController(~drumSynth, id: \drums)
      .open(
        "Superior Drummer 3",
        editor: true,
        verbose: true,
        action: _.editor
      );
  }.start;
}.();
