{
  ~group = Group.new;
  ~drums.isNil.not.if({ ~drums.close });

  ~drumsSynth = SynthDef(\drums, {
    var in = In.ar(\inBus.ir, 1);
    var amp = Lag.kr(Amplitude.kr(in, 0.01, 0.02), 1);
    Out.ar(0, VSTPlugin.ar(nil, 2, id: \drums, params: [0, amp]));
  }).add;

  Task {
    s.sync;
    ~drumsSynth = Synth(\drums, [\inBus: 8], target: ~group);
    ~drums = VSTPluginController(~drumsSynth, id: \drums)
      .open(
        "Superior Drummer 3",
        editor: true,
        verbose: true,
        action: _.editor,
      );
  }.start;
}.();
