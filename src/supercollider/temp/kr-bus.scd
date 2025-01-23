{
  ~bus = Bus.control(s, 1);

  SynthDef(\krBus, {
    Out.kr(~bus, LFPulse.kr(1).range(0.2, 0.6));
  }).add;

  ~routine = Routine {
    s.sync;
    (
      instrument: \krBus
    ).play
  }.play;

}.();
