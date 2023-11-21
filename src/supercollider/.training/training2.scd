s.boot;

// s.plotTree;

s.waitForBoot({
  var env1 = { |attack, release = 0.4|
    Env(
      levels: [0, 1, 0.3, 0],
      times: [attack, 0.2, release],
      curve: [-3, -1, -1],
      releaseNode: 2
    );
  };

  var snd = { |freq, velocity, t_gate, attack, release|
    var sig, env;
    var freqShift = XLine.kr(freq * 0.5, freq, attack);
    sig = [
      SinOsc.ar(freq: freqShift),
      SinOsc.ar(freq: freqShift)
    ];
    sig = Normalizer.ar(sig, 1, 0.1);

    env = EnvGen.kr(
      envelope: env1.(attack, release),
      gate: t_gate,
      doneAction: 2
    );
    (sig * velocity * env) ! 2;
  };

  var major = [0, 2, 4, 5, 7, 9, 11, 12];
  var minor = [0, 2, 3, 5, 7, 8, 10, 12];
  var b17 = [0, 4, 7, 11, 14, 17, 20];
  // var sequence = minor.slide(4, 1);
  var sequence = [0, 4, 7];

  sequence.do({ |i, v|
    var freq = 440 * (2 ** (i/12));
    var velocity = 0.1;
    // var t_gate = 1;
    var attack = 0.02;
    var release = 0.2;
    
    var play = {|t_gate = 1|
      var sound = snd.(
        freq: freq, 
        velocity: velocity, 
        t_gate: t_gate, 
        attack: attack, 
        release: release
      );
      Out.ar(0, sound);
    }.play;

    0.1.wait;
    4.do({
      play.set(\t_gate, 1);
      0.1.wait;
    });
    // 0.2.wait;
    // play.set(\t_gate, 1);
  })
});
