s.boot;

// s.meter;

s.waitForBoot({
  // var assetsAbsPath = 
  //   "\\\\wsl$\\u-Boulanger\\"
  //   "home\\utkusarioglu\\dev\\"
  //   "workshops\\signals-workshop\\"
  //   "assets";

  // var buffer = {
  //   var abspath = assetsAbsPath ++ "\\amen.wav";

  //   var vol = SinOsc.kr(10, 0, 0.5, 0.5);

  //   var b = Buffer.read(s, abspath);
  //   {PlayBuf.ar(2, b)}.play;
  // };



  var createSynthDefs = {
    SynthDef.new(\tone, {
      arg 
        freq = 50.midicps,
        amp = 1,
        t_gate = 1;
      var sig;

      var env = EnvGen.kr(
        envelope: Env(
          [0, 1, 0.3, 0],
          [0.02, 0.3, 1],
          [-2, -4, -4],
          2
        ),
        gate: t_gate,
        doneAction: 2,
      );

      sig = [
        LFTri.ar(freq),
        Pulse.ar(freq), 
        // SinOsc.ar(freq)
      ];
      sig = sig * env;
      sig = sig * amp;
      sig = sig ! 2;

      Out.ar(0, sig);
    }).add;
  };
  

  var doThings = {
    var offset, strumDuration, chordAmpDrop;
    offset = 60;
    strumDuration = 0.05;
    chordAmpDrop = 2;

    [0, 1, 2].do({
      arg o;

      [0, 4, 7, 11].do({ 
        arg v, i;
        var t, freq, amp;

        freq = ((offset + (o * 12)) + v).midicps;
        amp = (-1 * chordAmpDrop * i).dbamp;

        t = Synth(\tone, [
          freq: freq, 
          amp: amp, 
          // t_gate: 1
        ]);

        strumDuration.wait;
        // t.set(\t_gate, 0);
      });
    });
  };

  createSynthDefs.();
  1.wait;
  doThings.();
});
