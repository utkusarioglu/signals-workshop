Task {
  var length;
  length = 1;

  a = {
    var gen, env;
    var demandSeq, concatenatedSeq, trigger, freq;
    gen = Env(
      times: [0.15, 0.2, length/2, length],
      levels: [0.1, 1, 0.1, 0],
    );
    env = EnvGen.kr(gen, doneAction: Done.freeSelf);
    freq = 500 + (100 * LFSaw.kr(10 / length));
    // freq = 500;
    // freq = XLine.kr(100, 10000, 5) ++ XLine.kr(10000, 20);

    // Define the two sequences
    // demandSeq = Dseq([
    //     XLine.kr(100, 10000 / 100, 5), // Exponential growth: from 100 to 10000 in 5 steps
    //     XLine.kr(10000, 20 / 10000, 5) // Exponential decay: from 10000 to 20 in 5 steps
    // ]);

    // // Create a trigger to advance the demand sequence
    // trigger = Impulse.kr(5); // 10 steps per second (adjust as needed)

    // Evaluate the demand sequence
    // freq = Demand.kr(trigger, 0, demandSeq);

    Saw.ar([freq, freq], env);
    }.play;
  length.wait;
  a.free;
}.start;

// Task {
//   b = {SinOsc.ar(500)}.play;
//   2.wait;
//   b.free;
// }.start;

// Task {
//   c = {SinOsc.ar(600)}.play;
//   2.wait;
//   c.free;
// }.start;
