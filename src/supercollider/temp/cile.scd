{
  SynthDef(\cile, {
    var sig, db, other;

    #db, other = In.kr(\inBus.ir, 2);
    sig = WhiteNoise.ar();
    sig = BHiShelf.ar(
      sig,
      freq: MouseX.kr(
        s.sampleRate * 0.9, 
        s.sampleRate, 
        \exponential
      ),
      rs: MouseY.kr(0.7, 1, \linear),
      db: db.linlin(0, 1, -20, 0),
    );
    Out.ar(0, sig);
  }).add;

  Task {
    s.sync;
    ~bus = Bus.control(s, 1);
    (
      \instrument: \cile,
      \inBus: ~bus
    ).play;
    
  }.start;
}.();
