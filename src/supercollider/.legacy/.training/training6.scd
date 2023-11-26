s.boot;

// s.scope;
// s.meter;
// s.freqscope;


s.waitForBoot({
  var assetsRelPath;
  var amenWav;
  var amenSynth;
  var synth;

  assetsRelPath = File.getcwd ++ "\\assets";
  amenWav = Buffer.read(s, assetsRelPath ++ "\\sonic-pi\\ambi_choir.wav");

  SynthDef.new(\amen, {
    arg 
      buf,
      loop,
      startPos,
      rate,
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
      rate: BufRateScale.kr(amenWav) * rate,
      loop: loop,
      startPos: startPos,
    );

    sig = wave * env;
    sig = Pan2.ar(sig, panLine);

    Out.ar(0, sig);
  }).add;

  1.wait;

  [0].do({
    arg pitch;
    var reverse, startPos, rateReverse;

    reverse = false;

    if (
      reverse == true,
      {
        rateReverse = -1;
        startPos = amenWav.duration;
      },
      {
        rateReverse = 1;
        startPos = 0;
      }
    );

    Synth.new(\amen, [
      buf: amenWav,
      rate: pitch.midiratio * rateReverse,
      loop: 0,
      startPos: startPos * amenWav.sampleRate,
      // startPos: amenWav.duration * amenWav.sampleRate,
      pan: [-1, 1, 0.5],
      // attack: 0.02,
      times: [0.2, 3],
    ]);
    0.3.wait;
  });
  // synth.set(\times, [2, 6]);

  // 5.wait;
  // s.freeAll;
});
