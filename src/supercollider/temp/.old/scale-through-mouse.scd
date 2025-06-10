{
  // ~sound = {(1..3).collect(_.squared).collect(_ * 80).mirror.drop(-1).wrapExtend(10).collect(SinOsc.ar(_) * -10.dbamp).sum; }.plot;
  SynthDef(\aaa, {
    var sig, index, l, e, base, scale;
    base = 48;
    scale = 2.collect(_ * 12).collect(Scale.minor.degrees + _).flatten.collect(_ + 48).collect(_.midicps);

    index = MouseX.kr(0, scale.size, \linear).round;
    l = Select.kr(i, scale);
    e = MouseY.kr(-10, 0, \linear);

    sig = (1..10)
      .collect(_.squared)
      .collect({ | f |
        var amp = (f * e).dbamp;
        SinOsc.ar(f * l) * amp;
      })
      .sum;
    
    Out.ar(0, sig);
  }).add;

  Task {
    s.sync;
    (
      \instrument: \aaa,
    ).play
  }.start;

  // Task {
  //   var f = { 
  //     (1..9)
  //       .collect(_.squared)
  //       .collect({ | f |
  //         var amp = (-1 * (f / 2)).dbamp;
  //         SinOsc.ar(f * 80) * amp;
  //       })
  //       .sum
  //   };
  //   // f.plot;
  //   ~sound = f.play;
  //   3.wait;
  //   ~sound.free;    
  // }.start;
}.();
