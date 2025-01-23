{
  SynthDef(\thu, {
    var sig;

    sig = In.ar(8, 1);
    sig = VSTPlugin.ar(sig, 1, id: \thu);

    Out.ar(0, sig);
  }).add;

  Routine({
    s.sync;
    "Creating thu…".postln;
    ~thu = VSTPluginController(Synth(\thu), id: \thu)
      .open(
        "TH-U-64", 
        editor: true, 
        verbose: true, 
        action: _.editor
      );
  }).play;
}.();
