{
  var arr, f;
  
  arr = [1, 2, 3];
  f = { | a, b, c |
    #e, f, g = [c, a, b];
    ("e" + e).postln;
    ("f" + f).postln;
    ("g" + g).postln;
  };

  // f.(*arr);
  
  arr.do((_ + "-").postln)
}.();
