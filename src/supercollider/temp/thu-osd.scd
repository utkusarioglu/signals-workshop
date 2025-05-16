{
  SynthDef(\thu, {
    var sig;

    sig = In.ar(8, 1);
    sig = VSTPlugin.ar(sig, 1, id: \thu);

    Out.ar(0, sig);
  }).add;

  Task {
    s.sync;

    OSCdef(\thu, { | msg |
      var path, slot, value;
      #path, slot, value = msg;
      value.postln;
      ~thu.set(slot, value);
    }, "/thu");
    
    // ~thu = VSTPluginController(Synth(\thu), id: \thu)
    //   .open("TH-U-64", verbose: true, editor: true, action: _.gui);

  }.start;
}.();
