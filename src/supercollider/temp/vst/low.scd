{
  SynthDef(\low, { | freq |
    var sig;

    sig = In.ar(10, 1);

    sig = BHiShelf.ar(
      sig,
      freq: freq,
      // db: db,
      db: 0,
      rs: 1,
      mul: 1
    );

    Out.ar(0, sig);
  }).add;
}.();
