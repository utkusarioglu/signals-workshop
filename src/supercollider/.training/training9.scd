s.boot;

s.waitForBoot({
  var
    getAsset,
    assetWav,
    ding,
    t,
    yieldNote,
    soundRoutine,
    baseRoutine,
    seq
    ;

  getAsset = {
    arg assetSubpath;
    var assetsRelPath, assetAbsPath;

    assetsRelPath = File.getcwd ++ "/" ++ "assets";
    assetAbsPath = assetsRelPath ++ "/" ++ assetSubpath;

    Buffer.read(s, assetAbsPath.replace("/", "\\"));
  };

  assetWav = getAsset.("sonic-pi/bass_trance_c.wav");

  SynthDef.new(\glass, {
    arg 
      buf,
      loop,
      startPos,
      rate,
      lpf = 20000,
      hpf = 20,
      amp = 1,
      pan = #[0, 0, 0],
      times = #[0.02, 0.2];
    var sig, wave, env, panLine;

    panLine = Line.ar(*pan);

    env = EnvGen.kr(
      Env(
        levels: [0, 1, 0],
        times: times,
        curve: [0, 0],
      ),
      doneAction: Done.freeSelf,
    );

    wave = PlayBuf.ar(
      numChannels: 2, 
      bufnum: buf,
      rate: BufRateScale.kr(assetWav) * rate,
      loop: loop,
      startPos: startPos,
    );

    sig = wave * env;
    sig = HPF.ar(sig, hpf.clip(20, 20000));
    sig = LPF.ar(sig, lpf.clip(20, 20000));
    sig = Pan2.ar(sig, panLine);
    sig = sig * amp;

    Out.ar(0, sig);
  }).add;

  // 1.wait;
  
  t = TempoClock.new(80/60, 2).permanent_(true);

  // t.beats.postln;
  // t.beatsPerBar.postln;

  yieldNote = Routine.new({
    var base;
    base = 0;

    inf.do({
      base = (base + 1) % 12;
      yield(base);
      // yield([0, 2, 3, 5, 7, 8, 10].choose);
    });
  });
  

  ding = { 
    arg
      amp,
      pitch = 0
      ;

    // t.beats.postln;

    Synth.new(\glass, [
      buf: assetWav,
      rate: pitch.midiratio,
      loop: 0,
      amp: amp, 
      startPos: 0 * assetWav.sampleRate,
      // startPos: assetWav.duration * assetWav.sampleRate,
      // pan: [-1, 1, 0.5],
      // attack: 0.02,
      // times: [0, assetWav.duration],
      // amp: 22.dbamp,
      // lpf: 3300,
      // hpf: 2000,
      times: [0.02, 0.1],
    ]);
  };
  
  1.wait;

  // 16.do({
    // arg yield;

    // t.sched(0, { 
    //   ding.(
    //     pitch: yieldNote.next,
    //     amp: 0.dbamp,
    //     // amp: (-1 * yieldNote.next).dbamp
    //   ); 

    //   [1/2, 1/4].choose;
    //   // 1/4;
    // });
  // });

  soundRoutine = Routine.new({
    inf.do({
      ding.(
        pitch: yieldNote.next,
        amp: 0.dbamp,
        // amp: (-1 * yieldNote.next).dbamp
      ); 
      1/4.yield;
    });
  });


  // seq = Pseq(list: [1,4,5,7], repeats: 10).asStream;
  // seq = Pseq(list: [ Pseries(0, 7, 4) ], repeats: 10).asStream;
  seq = Pn(Pdup(2, Pseries(0, 7, 4)), 6).asStream;

  baseRoutine = Routine.new({
    inf.do({
      var p, m;

      p = seq.next;
      p.postln;

      ding.(
        pitch: p,
        amp: 0.dbamp,
        // amp: (-1 * yieldNote.next).dbamp
      ); 
      (1/8).yield;
    });
  });

  // Pxrand would be useful for atonal music
  // Pwrand creates weighted sequences

  baseRoutine.play(t, [0, 0])
});
