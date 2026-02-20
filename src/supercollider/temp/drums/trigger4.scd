{
  [
    ~detectorSynth,
    ~detectorFunc,
    ~detectorInst,
  ].do{ |n|
    n.notNil.if({ n.free })
  };

  ~detectorSynth = SynthDef(\kickDetector, {
      var input = In.ar(\inBus.ir, 1);
      var amp = Amplitude.ar(input, 0.01, 0.2); // tweak these
      var trig = amp > \threshold.ir;
      SendTrig.ar(trig, 1, amp); // trigger ID = 1
  }).add;

  Task {
    s.latency = 2e-2;
    s.sync;

    ~lastTrig = 0;
    ~minGap = 0.05; 

    ~detectorFunc = OSCFunc({ | msg |
        var now = SystemClock.seconds;
        var amp = msg[3];
        if ((now - ~lastTrig) > ~minGap) {
            ~lastTrig = now;
            amp.postln; 
            (
              group: ~group,
              type: \vst_midi,
              vst: ~drums,
              midinote: 36,
              amp: 1,
              // amp: amp
            ).play;

            // (
            //   group: ~group,
            //   type: \vst_midi,
            //   vst: ~drums,
            //   midinote: 86,
            //   amp: 0.8,
            //   // amp: amp
            // ).play;
        }
    }, '/tr', s.addr);

    ~detectorInst = (
      group: ~group,
      instrument: \kickDetector,
      inBus: 8,
      threshold: 0.7
    ).play;

  }.start;
}.();
