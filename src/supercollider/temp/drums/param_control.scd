{
  [~group, ~bus, ~ctrDef, ~synthDef].do({ | g | g.notNil.if({ g.free }); });
  ~drumsController.notNil.if({ ~drumsController.close });
  

  ~bus = Bus.control(s, 1);
  ~group = Group.new;

  ~ctrDef = SynthDef(\ctr, {
    Out.kr(~bus, SinOsc.kr(2));
  }).add;

  ~synthDef = SynthDef(\drums, {
    var ctr = In.kr(~bus, 1);
    var sig = VSTPlugin.ar(nil, id: \drums, params: [1, ctr]);
    Out.ar(\outBus.ir, sig);
  }).add;
  
  Task {
    s.sync;

    ~ctrSynth = Synth(\ctr, [\group: ~group]);

    ~drumsSynth = Synth(\drums, [\outBus: 0, \group: ~group]);
    ~drumsController = VSTPluginController(~drumsSynth, id: \drums)
      .open(
        "Superior Drummer 3",
        verbose: true,
        editor: true,
        action: _.editor
      );

    5.wait;
    ~bus.scope;

  }.start;

}.();
