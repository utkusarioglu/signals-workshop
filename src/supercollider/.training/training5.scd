s.boot;

// s.scope;
// s.meter;
// s.freqscope;


s.waitForBoot({
  var assetsRelPath;
  var amenWav;
  var amenSynth;

  assetsRelPath = File.getcwd ++ "\\assets";
  amenWav = Buffer.read(s, assetsRelPath ++ "\\amen.wav");

  SynthDef.new(\amen, {
    arg 
      buf,
      loop,
      startPos,
      rate;
    var sig, wave, env;

    env = EnvGen.kr(
      Env(
        [0, 1, 0],
        [0.02, 1],
        [0, 0],
      ),
      doneAction: Done.freeSelf,
    );

    wave = PlayBuf.ar(
      numChannels: 2, 
      bufnum: buf,
      // doneAction: Done.freeSelf,
      rate: BufRateScale.kr(amenWav) * rate, 
      loop: loop,
      startPos: startPos
    );

    sig = wave * env;

    Out.ar(0, sig);
  }).add;

  1.wait;

  Synth.new(\amen, [
    buf: amenWav,
    rate: 0.midiratio,
    loop: 0,
    startPos: 0 * amenWav.sampleRate,
  ]);

  // 5.wait;
  // s.freeAll;
});
