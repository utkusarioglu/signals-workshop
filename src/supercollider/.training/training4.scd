s.boot;

// s.scope;
// s.meter;



s.waitForBoot({

  var createSynthDefs = {
    var waveform = {
        arg freq = 60.midicps;
        var sig;

        sig = [
          Saw.ar(freq),
          Pulse.ar(freq)
        ];
    };

    var envelope = {
      arg t_gate = 1;

      EnvGen.kr(
        envelope: Env(
          [0, 1, 0.3, 0],
          [0.02, 0.3, 3],
          [-2, -4, -4],
          2
        ),
        gate: t_gate,
        doneAction: 2,
      );
    };

    var signal = {
      arg
        freq = 60.midicps,
        t_gate = 1,
        amp = 1;
      var sig;

      sig = waveform.(freq) * envelope.(t_gate) * amp;
    };

    var showPlots = {
      {waveform.()}.plot();
      {envelope.()}.plot(0.5);
      // {signal.()}.plot(1);
    };

    // showPlots.();

    SynthDef.new(\tone, {
      arg 
        freq = 50.midicps,
        amp = 1,
        t_gate = 1;
      var sig, freqLag, env;

      sig = signal.(freq, t_gate, amp);
      sig = sig ! 2;
      Out.ar(0, sig);
    }).add;
  };


  var makeMusic = {
    var playSequence, getFreq, createSequence;
    var sequence;

    getFreq = {
      arg basePitch, octave, offsetPitch;

      ((basePitch + (octave * 12)) + offsetPitch).midicps;
    };

    createSequence = {
      arg
        base,
        chord,
        contour;
      var sequence; 
        
      sequence = Array.new();

      contour.do({
        arg octave;

        chord.do({ 
          arg offsetPitch;
          var seqFreq;

          seqFreq = getFreq.(base, octave, offsetPitch);
          sequence = sequence ++ [seqFreq];
        });
      });

      sequence;
    };

    playSequence = {
      arg 
        sequence,
        strumDuration,
        chordAmpDrop,
        stressModulo;
      var tone;

      tone = Synth(\tone, [
        freq: getFreq.(0, 0, 0), 
        amp: 0,
        t_gate: 1
      ]);

      sequence.do({ 
        arg value, index;

        if ( (index % stressModulo) == 0,
          {
            tone.set(\t_gate, 1);
            tone.set(\amp, 0.dbamp);
          },
          {
            tone.set(\amp, chordAmpDrop);
          }
        );

        strumDuration.wait;
        tone.set(\freq, value);
      });
    };

    sequence = createSequence.(
      base: 48, 
      // chord: [0, 4, 7, 11], 
      // chord: [0, 3, 7, 10], 
      chord: [0, 2, 4, 6, 8, 10], 
      contour: Array.series(4)
    );

    sequence.postln;

    playSequence.(
      sequence: sequence,
      strumDuration: 0.1,
      chordAmpDrop: -2.dbamp,
      stressModulo: 6,
    );
  };

  createSynthDefs.();
  1.wait;
  makeMusic.();
});
