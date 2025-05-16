{
  OSCdef(\drums).free;

  Task {
    var tempo;

    s.sync;
    
    tempo = 120;

    OSCdef(\drums, { | msg |
      var path, midinote, vel, amp;
      #path, midinote, vel = msg;
      
      case
        { [36, 59].includes(midinote) } {
          (
            \type: \vst_midi,
            \vst: ~drums,
            \midinote: midinote,
            \amp: vel.linlin(0, 127, 0, 1),
          ).play;
        }
        { [38].includes(midinote) } {
          Task {
            var jitter = 0.06.rand;
            2.do({ | i |
              (
                \type: \vst_midi,
                \vst: ~drums,
                \midinote: midinote,
                \amp: vel.linlin(0, 127, 0, 1 - (i * 0.60)),
              ).play;

              ((60/tempo/3) + jitter).wait;
            });
          }.start;
        }
        { true } {
          Task {
            var jitter = 0.05.rand;

            4.do({ | i |
              (
                \type: \vst_midi,
                \vst: ~drums,
                \midinote: midinote,
                \amp: vel.linlin(0, 127, 0, 1 - (i * 0.25)),
              ).play;

              ((60/tempo/3) + jitter).wait;
            });
          }.start;
        }
    }, "/drums")
  }.start;
}.();
