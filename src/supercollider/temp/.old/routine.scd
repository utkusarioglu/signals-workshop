/* 
r = Routine({
    var delta;
    loop {
        delta = rrand(1, 3) * 0.5;
        "Will wait ".post; delta.postln;
        delta.yield;
    }
});


10.do({
  r.next;
});

r.stop; */
SynthDef(\singrain, { |freq = 440, amp = 0.2, sustain = 1, out|
    var sig;
    sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.perc(0.01, sustain), doneAction: Done.freeSelf);
    Out.ar(out, sig ! 2);    // sig ! 2 is the same as [sig, sig]
}).add;

r = Task({
    var delta, freqs, base, speed;
    speed = 0.1 * exprand(1, 8);
    base = 400;
    freqs = [0, 2, 3, 5, 7, 9, 10].collect({ | s |
      base * (2 ** (s/12))
    });
    loop {
        delta = rrand(1, 3) * speed;
        // Synth(\singrain, [freq: exprand(200, 800), amp: rrand(0.1, 0.5), sustain: delta * 0.8]);
        Synth(\singrain, [
          freq: freqs.choose(),
          amp: rrand(0.1, 0.25),
          sustain: delta * 0.8
        ]);
        delta.yield;
    }
});

4.do({ r.start });
