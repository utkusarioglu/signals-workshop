{
  OSCdef(\drumsJitter).free;
  OSCdef(\drumsFlat).free;

  Task {
    var tempo;

    s.sync;
    
    tempo = 120;

    OSCdef(\drumsFlat, { | msg |
      var path, midinote, vel, amp;
      #path, midinote, vel = msg;
      
      midinote.postln;
      (
        \type: \vst_midi,
        \vst: ~drums,
        \midinote: midinote,
        // \amp: vel.linlin(0, 127, 0, 1),
        \amp: vel,
      ).play;
    }, "/drums/flat");

    OSCdef(\drumsJitter, { | msg |
      var path, midinote, vel, amp;
      #path, midinote, vel = msg;
      
      case
        { [59, 53].includes(midinote) } {
          (
            \type: \vst_midi,
            \vst: ~drums,
            \midinote: midinote,
            \amp: vel.linlin(0, 127, 0, 1),
          ).play;
        }
        { [38].includes(midinote) } {
          Task {
            // var jitter = 0.06.rand;
            var jitter = 0;
            1.do({ | i |
              (
                \type: \vst_midi,
                \vst: ~drums,
                \midinote: midinote,
                \amp: vel.linlin(0, 127, 0, 1 - (i * 0.70)),
              ).play;

              ((60/tempo/3) + jitter).wait;
            });
          }.start;
        }
        { true } {
          Task {
            // var jitter = 0.05.rand;
            var jitter = 0;

            4.do({ | i |
              (
                \type: \vst_midi,
                \vst: ~drums,
                \midinote: midinote,
                \amp: vel.linlin(0, 127, 0, 1 - (i * 0.10)),
              ).play;

              ((60/tempo/8) + jitter).wait;
            });
          }.start;
        }
    }, "/drums/jitter");
  }.start;
}.();
