{
  SynthDef(\gab, {
    var snd, freq, high, lfo;
    freq = \freq.kr(440) 
      * (Env.perc(1e-3, 8e-2, curve: -1).ar * 48 * \bend.kr(1)).midiratio;
    snd = Saw.ar(freq);
    snd = (snd * 100).tanh + ((snd.sign - snd) * -8.dbamp);
    high = HPF.ar(snd, 300);
    lfo = SinOsc.ar(8, [0, 0.5pi]).range(0, 0.01);
    high = high.dup(2) + (DelayC.ar(high, 0.01, lfo) * -2.dbamp); 
    snd = LPF.ar(snd, 100).dup(2) + high;
    snd = RLPF.ar(snd, 7000, 2);
    snd = BPeakEQ.ar(snd, \ffreq.kr(3000)
      * XLine.kr(1, 0.8, 0.3), 0.5, 15);
    snd = snd * Env.perc.ar(2, \gate.kr(1));
    Out.ar(\outBus.ir(0), snd * \amp.kr(0.1));
  }).add;

  SynthDef(\hoover, {
    var snd, freq, bw, delay, decay;

    freq = \freq.kr(440);
    freq = freq * Env([-5, 6, 0], [0.1, 1.7], [\lin, -4]).kr.midiratio;
    bw = 1.035;
    snd = { 
      DelayN.ar(
        Saw.ar(freq * ExpRand(bw, 1/bw))
          + Saw.ar(freq * 0.5 * ExpRand(bw, 1/bw)),
        1e-2, 
        Rand(0, 1e-2)
      );
    }.dup(20);
    // snd = (Splay.ar(snd) * 3).atan;
    snd = snd * Env.asr(0.01, 1.0, 1.0).kr(0, \gate.kr(1));
    snd = FreeVerb2.ar(snd[0], snd[1], 0.3, 0.9);
    snd = snd * Env.asr(0, 1.0, 4, 6).kr(2, \gate.kr(1));
    Out.ar(\out.kr(0), snd * \amp.kr(0.1));
  }).add;
  
  Task {
    var durations = [2, 1, 1, 1, 3/4, 1/4, 1/2, 3/4, 1/4, 1/2];
    // var durations = [1 - 0.25, 0.25, 0.5, 0.5];
    // var durations1 = [2, 1, 1, 1, 3/4, 1/4, 1/2, 3/4, 1/4, 1/2];
    var durations1 = [1, 1, 1, 1].normalizeSum;
    var durations2 = [1, 1, 1, 1, 1].normalizeSum;
    s.sync;
    s.freeAll;
    // TempoClock.tempo_(1);
    ~play = Ppar([
      Pbind(*[
        instrument: \gab,
        outBus: 0,
        amp: -23.dbamp,
        freq: 48,
        legato: 0.8,
        dur: Pseq(durations, 8),
        ffreq: Pseq((0..(durations.size * 4 - 1)).normalize, inf).linexp(0, 1, 100, 4000),
        bend: Pfuncn({ |x| if(x < 0.5, 0.4, 1)}, inf) <> Pkey(\dur),
      ]),
      // Pbind(*[
      //   instrument: \gab,
      //   outBus: 0,
      //   amp: -23.dbamp,
      //   freq: 60,
      //   legato: 0.8,
      //   dur: Pseq(durations2, 8),
      //   ffreq: Pseq((0..(durations2.size * 4 - 1)).normalize, inf).linexp(0, 1, 100, 4000),
      //   bend: Pfuncn({ |x| if(x < 0.5, 0.4, 2)}, inf) <> Pkey(\dur),
      // ]),
      Pbind(*[
        instrument: \hoover,
        amp: -20.dbamp,
        midiratio: 74,
        dur: durations.sum * 2,
        sustain: 7,
      ])
    ]).play(TempoClock(210/60));



    // 2.wait;
    // s.freeAll;
  }.start;
}.();
