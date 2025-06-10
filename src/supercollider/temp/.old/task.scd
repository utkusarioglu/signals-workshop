{
  Task {
    Pbind(
      \note, Pseq(Scale.major.degrees.mirror.drop(-1), 2),
      \dur, 1/4
    ).play;
  }.start;
}.();
