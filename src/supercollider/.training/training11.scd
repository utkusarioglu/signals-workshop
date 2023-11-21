s.boot;

s.plotTree;
// s.freqscope;

s.waitForBoot({
  var synthDefs, music;

  synthDefs = {
    SynthDef(\s1s, {
      arg freq, amp, channel, gate = 1;
      var sig, env;

      env = EnvGen.kr(
        envelope: Env(
          levels: [0, 1, 0.2, 0],
          times: [0.01, 0.03, 0.05, 1],
          curve: 1,
          releaseNode: 2,
        ),
        // envelope: Env.adsr(),
        gate: gate,
        doneAction: Done.freeSelf,
      );

      sig = SinOsc.ar(freq);
      sig = sig * env;
      sig = sig * amp;

      Out.ar(channel, sig);
    }).add;
  };

  music = {
    var r1, r2, rIncrement, rDecrement;

    rIncrement = Routine({
      var root, increment;
      root = 48;
      increment = 0;

      inf.do({
        increment = increment + 1;

        (root + (increment % 12)).yield;
      })
    });

    rDecrement = Routine({
      var root, decrement;
      root = 60;
      decrement = 0;

      inf.do({
        decrement = decrement - 1;

        (root + (decrement % 12)).yield;
      })
    });

    r1 = Routine({
      inf.do({
        (
          instrument: \s1s, 
          freq: rIncrement.next.midicps, 
          amp: 0.2, 
          channel: 1,
        ).play;

        (1/4).yield
      });
    });

    r2 = Routine({
      inf.do({
        (
          instrument: \s1s, 
          freq: rDecrement.next.midicps, 
          amp: 0.2, 
          channel: 0,
        ).play;

        (1/4).yield
      });
    });
    
    r1.play;
    r2.play;
  };

  synthDefs.();
  wait(1);
  music.();
});
