{
  ~thu.isNil.not.if({ ~thu.close });
  OSCdef(\phase).free;

  SynthDef(\phase, {
    var sig;

    sig = In.ar(8, 1);
    sig = VSTPlugin.ar(sig, 2, id: \thu);

    Out.ar(0, sig);
  }).add;

  Task {
    s.sync;
    
    ~thu = VSTPluginController(Synth(\phase), id: \thu)
      .open(
        "TH-U-64", 
        editor: true, 
        verbose: true, 
        action: _.editor
      );
  }.start;
}.();
