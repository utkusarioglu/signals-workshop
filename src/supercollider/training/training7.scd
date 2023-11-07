s.boot;

// s.scope;
// s.meter;
// s.freqscope;


s.waitForBoot({
  var 
    assetWav,
    assetSynth,
    synth,
    getAsset,
    sequence,
    routine,
    t
    ;

  getAsset = {
    arg assetSubpath;
    var assetsRelPath, assetAbsPath;

    assetsRelPath = File.getcwd ++ "/" ++ "assets";
    assetAbsPath = assetsRelPath ++ "/" ++ assetSubpath;

    Buffer.read(s, assetAbsPath.replace("/", "\\"));
  };

  assetWav = getAsset.("sonic-pi/ambi_glass_hum.wav");

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

  1.wait;
  
  t = TempoClock.new(100/60).permanent_(true);

  t.beats.postln;
  t.beatsPerBar.postln;

  routine = Routine.new({
    "play".postln;
    sequence = [0, 4, 7, 11];

    sequence.do({
      arg pitch;

      Synth.new(\glass, [
        buf: assetWav,
        rate: pitch.midiratio,
        loop: 0,
        startPos: 0 * assetWav.sampleRate,
        // startPos: assetWav.duration * assetWav.sampleRate,
        // pan: [-1, 1, 0.5],
        // attack: 0.02,
        // times: [0, assetWav.duration],
        amp: 22.dbamp,
        lpf: 3300,
        hpf: 2000,
        times: [0.02, 2],
      ]);

      yield(1/4);
    });
  });
  
  t.sched(2, { routine.play; 2}); 
  t.sched(6, { routine.play; 2}); 

  // routine.play;

  // 4.wait;
  // routine.reset;
  // routine.play;
  
  // synth.set(\times, [2, 6]);

  // 5.wait;
  // s.freeAll;
});
