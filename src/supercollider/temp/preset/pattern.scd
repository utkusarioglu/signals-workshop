~play.stop;
~ff = { [0, -1, -2].choose.dbamp };
~common = Pbind(*[
  \type: \vst_midi,
  \vst: ~drums,
  \amp: Pfunc(~ff),
]);


~pattern = ();

~pattern[\one] = Ppar([
  Pbindf(*[
    ~common,
    //\amp: Pseq([0.9, 0.8, 0.8, 0.6], inf),
    \midinote: Pseq([36, Pshuf([18, 37])], inf),
    \dur: 1/4,
  ]),
  Pbindf(*[
    ~common,
    \midinote: Pseq([\rest, 38], inf),
    \dur: 1/2,
  ]),

  Pbindf(*[
    ~common,
    \midinote: Pseq([57, 49], inf),
    \midinote: Pshuf([57, 49, 27, 52]),
    \dur: 2/1,
  ])
]);
~pattern[\two] = Ppar([
  Pbindf(*[
    ~common,
    \amp: Pseq([0.9, 0.8, 0.8, 0.6], inf),
    \midinote: Pseq([36], inf),
    \dur: 1/2,
  ]),
  Pbindf(*[
    ~common,
    \amp: 0.6,
   // \midinote: Pdup(2, Prand([41, 43, 45, 47], inf)),
        \midinote: Pdup(2, Pshuf([41, 43, 45, 47], inf)),
    // \midinote: Pseq([41, 41, 41, 43, 45, 45, 47, 47], inf),
    \dur: Pdup(inf, Prand([1/6, 1/8])),
  ]),
  Pbindf(*[
    ~common,
    \midinote: Pseq([\rest, 38], inf),
    \dur: 1/2,
  ]),

  Pbindf(*[
    ~common,
    \midinote: Pseq([57, 49], inf),
    \dur: 2/1,
  ])
]);

~pattern[\metal] = Ppar([
  Pbindf(*[
    ~common,
    \midinote: Pseq([36], inf),
    \dur: 1/8
  ]),
  Pbindf(*[
    ~common,
    \midinote: Pseq([38], inf),
    \dur: 1/2,
    \timingOffset: 1/4
  ]),
  Pbindf(*[
    ~common,
    \midinote: Pseq([49], inf),
    \dur: 1/2,
    \timingOffset: 1/2
  ]),
]);

~pattern[\aksak] = Ppar([
  Pbindf(*[
    ~common,
    \midinote: Pseq([
      Pseq([36, \rest], 3),
      Pseq([36, \rest, \rest], 1),
    ], inf),
    \dur: 1/4,
    \amp: 1
  ]),
  Pbindf(*[
    ~common,
    \midinote: Pseq([
      Pseq([\rest, 38], 3),
      Pseq([\rest, 38, 38], 1),
    ], inf),
    \dur: 1/4,
    \amp: 0.8
  ]),
  Pbindf(*[
    ~common,
    \midinote: Pseq([
      Pseq([27, \rest], 1),
       Pseq([\rest, \rest], 2),
      Pseq([49, \rest, \rest], 1),
    ], inf),
    \dur: 1/4,
    \amp: 0.8
  ]),
]);

~pattern[\solea] = Ppar([
  Pbindf(*[
    ~common,
    \midinote: Pseq([
      Pseq([36, 36, 38], 2),
      Pseq([36, 38], 2),
      Pseq([36, 36], 1)
    ], inf),
    \dur: 1/4,
    \amp: 0.8
  ]),
  Pbindf(*[
    ~common,
    \midinote: 46,
    \dur: 3
  ]),
]);

~pattern[\bulerias1] = Ppar([
  Pbindf(*[
    ~common,
    \midinote: Pseq([
      Pseq([36, 36, 38], 2),
      Pseq([36, 38], 3),
    ], inf),
    \dur: 1/4,
    \amp: 0.8
  ]),
    Pbindf(*[
    ~common,
    \midinote: 46,
    \dur: 3
  ]),
]);

~pattern[\bulerias2] = Ppar([
  Pbindf(*[
    ~common,
    \midinote: Pseq([
      Pseq([36, 36, 38], 1),
      Pseq([36, 36, 36], 1),
      Pseq([38, 38], 1),
      Pseq([36, 38], 2)
    ], inf),
    \dur: 1/4,
    \amp: 0.8
  ]),
  Pbindf(*[
    ~common,
    \midinote: 46,
    \dur: 3,
  ])
]);

~play = Pgroup(Pseq([
 // Pfindur(4, ~pattern[\one]),
 // Pfindur(2, ~pattern[\two]),
 // Pfindur(4, ~pattern[\metal]),
  // Pfindur(9/4, ~pattern[\aksak]),
   Pfindur(12/4, ~pattern[\solea]),
  Pfindur(12/4, ~pattern[\bulerias1]),
  // Pfindur(12/4, ~pattern[\bulerias2]),
], 2)).play(TempoClock.new(0.9));
