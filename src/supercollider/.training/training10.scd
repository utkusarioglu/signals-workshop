s.boot;

s.freqscope;

s.waitForBoot({
  var voice, chord, bars;

  SynthDef.new(\pulsed, {
    arg freq, amp;
    var sig, env;

    env = EnvGen.kr(
      envelope: Env(
        levels: [1, 1, 0],
        times: [0.1, 0.2, 0.3],
        curve: 1,
        releaseNode: 2,
      ),
      gate: 1,
      doneAction: Done.freeSelf,
    );

    sig = Pulse.ar(freq);
    sig = sig * env;
    sig = sig * amp;
    sig = sig ! 2;

    Out.ar(0, sig);
  }).add;

  wait(1);
  
  bars = 4;
  chord = [0, 5, 7, 12];

  voice = {
    arg root, seq, interval, amp;
    var routine;
    
    routine = Routine({
      seq.do({
        arg pitch;

        (
          instrument: \pulsed, 
          freq: (root + pitch).midicps,
          amp: amp,
        ).play;

        (interval).yield;
      });
    });
  };

  voice.(
    root: 84,
    seq: Pn(Prand(chord, 64), bars),
    interval: 1/16,
    amp: -30.dbamp,
  ).play;

  voice.(
    root: 72,
    seq: Pn(Prand(chord, 32), bars),
    interval: 1/8,
    amp: -2.dbamp,
  ).play;

  voice.(
    root: 60,
    seq: Pn(Prand(chord, 16), bars),
    interval: 1/4,
    amp: -2.dbamp,
  ).play;

  voice.(
    root: 48,
    seq: Pn(Prand(chord, 8), bars),
    interval: 1/2,
    amp: -10.dbamp,
  ).play;

  voice.(
    root: 36,
    seq: Pn(Prand(chord, 4), bars),
    interval: 1,
    amp: -2.dbamp,
  ).play;
});
