{
  SynthDef(\test, {
    var sig;
    sig = In.ar(8, 1);

    sig = VSTPlugin.ar(sig, 2, id: \test);

    Out.ar(10, sig);
  }).add;

}.();
