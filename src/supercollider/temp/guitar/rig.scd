{
  ~rig.isNil.not.if({
    ~rig.close;
    ~rig.free;
  });
  Synth(\guitar).free;

  SynthDef(\guitar, {
     var sig;
     sig = In.ar(\inBus.ir);
     sig = VSTPlugin.ar(sig, 2, id: \guitar);
     Out.ar(\outBus.ir, sig);
  }).add;
  
  Task {
    s.sync;
    ~synth = Synth(\guitar, [\inBus, 10, \outBus, 0]);
    ~rig = VSTPluginController(~synth, id: \guitar)
      .open(
        "Guitar Rig 6",
        editor: true,
        verbose: true,
        action: _.editor,
      );
  }.start;
}.();
