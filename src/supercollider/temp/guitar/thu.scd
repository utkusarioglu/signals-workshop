{
  ~thu.isNil.not.if({ 
    ~thu.close;
    ~thu.free;
  });
  OSCdef(\phase).free;

  SynthDef(\phase, {
    var sig;

    sig = In.ar(\inBus.ir, 1);
    sig = VSTPlugin.ar(sig, 2, id: \thu);

    Out.ar(\outBus.ir, sig);
  }).add;

  Task {
    s.sync;
    
    ~thu = VSTPluginController(Synth(\phase, [\inBus, 10, \outBus, 0]), id: \thu)
      .open(
        "TH-U-64", 
        editor: true, 
        verbose: true, 
        action: _.editor
      );
  }.start;
}.();
