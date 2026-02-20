~drumPattern.notNil.if({~drumPattern.stop});

~drumPattern = Ppar([
  Pbind(*[
    target: ~group,
    type: \vst_midi,
    vst: ~drums,
    midinote: Pseq([\rest, 39], inf),
    // amp: Pseq([1, 1], inf)
    amp: 1
  ]),
  Pbind(*[
    target: ~group,
    type: \vst_midi,
    vst: ~drums,
    midinote: 16,
    // amp: Pseq([1, 1], inf)
    amp: 1
  ]),
  Pbind(*[
    target: ~group,
    type: \vst_midi,
    vst: ~drums,
    midinote: Pseq([\rest, 46]),
    // amp: Pseq([1, 1], inf)
    amp: 1,
    dur: 4,
  ])
]).play(TempoClock(2));
