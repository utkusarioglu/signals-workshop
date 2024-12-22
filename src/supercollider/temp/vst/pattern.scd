{
  Pdef(\seq, Pbind(
    \instrument, \low,
    \freq, Prand([200, 2000, 400], inf),
    // \db, Prand([0, 10, 20], inf),
  ));
}.();
