{
  SynthDef(\thu, {
    var sig;

    sig = In.ar(8, 1);
    sig = VSTPlugin.ar(sig, 1, id: \thu);

    Out.ar(0, sig);
  }).add;

  Routine({
    1.wait;
    "Creating thu".postln;
    ~thu = VSTPluginController(Synth(\thu), id: \thu);

    3.wait;
    "Opening thu".postln;
    ~thu.open("TH-U-64", editor: true, verbose: true);

    3.wait;
    "Opening editor".postln;
    ~thu.editor;
  }).play;
}.();
