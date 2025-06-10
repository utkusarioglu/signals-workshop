{
  ~bass.isNil.not.if({ ~bass.close });
  // OSCdef(\bass).free;
  // OSCdef(\loopers).free;

  SynthDef(\bass, {
    Out.ar(0, VSTPlugin.ar(nil, 2, id: \bass));
  }).add;

  Task {
    var vstId;

    s.sync;

    // ~vstName = ["EZbass","Surge XT Effects", "synister"];
    // ~loopers = [0];
    // vstId = 0;

    ~bass = VSTPluginController(Synth(\bass), id:\bass)
      .open(
        "EZbass",
        editor: true,
        verbose: true,
        action: _.editor
      );

    // OSCdef(\loopers, { | msg |
    //   var path, pattern;

    //   msg.removeAt(0);
    //   ~loopers = msg;
    //   ~loopers.postln;
    // }, "/vst/loopers");


    // OSCdef(\bass, { | msg |
    //   var path, midinote, dur, amp;
    //   #path, midinote, dur, amp = msg;

    //   (
    //     \type: \vst_midi,
    //     \vst: ~bass,
    //     \midinote: 3.collect(midinote + (_ * 12)).choose,
    //     \dur: dur,
    //     \amp: amp
    //   ).play;
    // }, "/bass");
  }.start;
}.();
