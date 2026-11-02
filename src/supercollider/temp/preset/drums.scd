~playThing = {
  ~common = Pbind(*[
    \type: \vst_midi,
    \vst: \drums,
    \amp: 1
  ]);

  ~basic = Pbindf(*[
    ~common,
    \midinote: Pseq([
      Pseq([36, 36, 38], 3),
      Pseq([36, 38], 2)
    ], inf),
    \dur: 1/4
  ]);

  ~p = Pseq([Pfindur(13/4, ~basic)], 2);
  // 5.wait;
  ~p.play;
  30.wait;
  ~p.free;
};

~addSynth = {
  SynthDef(\drums, {
    var sig = VSTPlugin.ar(nil, 2, id: \drums);
    Out.ar(\outBus.ir(0), sig);
  }).add;

  Task {
    s.sync;

    ~synth = Synth(\drums, [\outBus: 0]);
    ~drums = VSTPluginController(~synth, id: \drums)
      .open(
        "Superior Drummer 3",
        verbose: true,
        editor: true,
        action: { |e|
          e.editor;
          e.moveEditor(1920, 100);
        }
      );
    // 5.wait;
    // ~playThing.();
  }.start;
};

// ~playThing.();
~addSynth.();

// Task {
//   s.sync;

//   ~synth = Synth(\drums, [\outBus: 0]);
//   ~controller = VSTPluginController(~synth, id: \drums)
//     .open(
//       "Superior Drummer 3",
//       verbose: true,
//       editor: true,
//       action: { |e|
//         e.editor;
//         e.moveEditor(1920, 100);
//       }
//     );

// }.start;
