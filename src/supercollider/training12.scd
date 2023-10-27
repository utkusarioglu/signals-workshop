s.boot;

s.waitForBoot({
  var synthDefs, music, t;

  t = TempoClock(100/60);

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
      sig = sig ! 2;

      Out.ar(channel, sig);
    }).add;
  };

  music = {
    var p, b;

    b = Pbind(
      \instrument, \s1s,
      \freq, Prand([300, 200, 100, 500, 600], inf),
      \amp, Pexprand(0.1, 0.7, inf),
      \dur, Pgeom(0.1, 1.5, inf),
      \sustain, 0.1,
    );

    p = b.play(t);
    // inf.do({
    //   p.next(()).play;
    //   (1/4).yield;
    // });
  };

  synthDefs.();
  wait(1);
  music.();
});
