{
  var r;
  var a = 5;
  r.isNil.if({ a > 4}, false).if(a, r)
}.()
