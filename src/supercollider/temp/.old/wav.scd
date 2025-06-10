if (b.notNil, { },
  { b = [] }
);

// 100.do({
b = b.add(Buffer.read(s, [File.getcwd, "assets", "wav", "amen.wav"].reduce('+/+')));
// });

// t = Task({
//   s.sync;
//   {PlayBuf.ar(2, b.last, b.last.sampleRate/ s.sampleRate, loop: 1, doneAction: 2)}.play;
//   // b.sampleRate.postln;
// }).start;
