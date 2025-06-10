{
  SynthDef(\thu, {
    var 
      sig, sig1, sig2, 
      krs,
      vol1, vol2,
      freq1, freq2,
      phase2 
    ;

    krs = In.kr(0, 8);
    vol1 = krs[0].linlin(0, 1, 0, 10);
    freq1 = krs[1].linlin(0, 1, 0, 10);
    vol2 = krs[2].linlin(0, 1, 0, 10);
    freq2 = krs[3].linlin(0, 1, 0, 10);
    phase2 = krs[4].linlin(0, 1, 0, pi);

    sig = In.ar(8, 1);

    // sig1 = sig * cleanVolume * SinOsc.kr();
    sig1 = VSTPlugin.ar(sig, 1, id: \thu1) * vol1;
    sig1 = sig1 * SinOsc.kr(freq1);

    sig2 = VSTPlugin.ar(sig, 1, id: \thu2) * vol2;
    sig2 = sig2 * SinOsc.kr(freq2, phase2);

    sig = sig1 + sig2;

    Out.ar(0, sig);
  }).add;

  Routine({
    1.wait;
    "Creating thu".postln;
    ~thu1 = VSTPluginController(Synth(\thu), id: \thu1);
    ~thu2 = VSTPluginController(Synth(\thu), id: \thu2);

    3.wait;
    "Opening thu".postln;
    ~thu1.open("TH-U-64", editor: true, verbose: true);
    ~thu2.open("TH-U-64", editor: true, verbose: true);

    3.wait;
    "Opening editor".postln;
    ~thu1.editor;
    ~thu2.editor;
  }).play;
}.();
