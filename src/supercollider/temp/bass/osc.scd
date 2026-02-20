{
  OSCdef(\bass).free;

  OSCdef(\bass, { | msg |
    var path, midinote, dur, amp;
    #path, midinote, dur, amp = msg;

    (
      \type: \vst_midi,
      \vst: ~bass,
      \midinote: midinote,
      \dur: dur,
      \amp: amp.linlin(0, 127, 0, 1),
    ).play;
  }, "/bass");
}.();
