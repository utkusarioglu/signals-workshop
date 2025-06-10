{
  ~guitar.isNil.not.if({
    ~guitar.close;
    ~guitar.free;
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
    ~sy = Synth(\guitar, [\inBus, 10, \outBus, 0]);
    ~guitar = VSTPluginController(~sy, id: \guitar)
      .open(
        "Guitar Rig 6",
        editor: true,
        verbose: true,
        action: _.editor,
      );
  }.start;
}.();
