{
  // ~sound = {(1..3).collect(_.squared).collect(_ * 80).mirror.drop(-1).wrapExtend(10).collect(SinOsc.ar(_) * -10.dbamp).sum; }.plot;
  Task {
    var f = { (1..4).collect(_.squared).collect(_ * 80).collect(SinOsc.ar(_) * -10.dbamp).sum; };
    // f.plot;
    ~sound = f.play;
    3.wait;
    ~sound.free;    
  }.start;
}.();
