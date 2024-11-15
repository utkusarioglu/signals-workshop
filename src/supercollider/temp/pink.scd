Task {
  a = {SinOsc.ar(400)}.play;
  2.wait;
  a.free;
}.start;

Task {
  b = {SinOsc.ar(500)}.play;
  2.wait;
  b.free;
}.start;

Task {
  c = {SinOsc.ar(600)}.play;
  2.wait;
  c.free;
}.start;
