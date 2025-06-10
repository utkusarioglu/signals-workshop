var main = {
  SynthDef(\g, {
    var sig;
    sig = In.ar(8, 1);
    sig = sig * SinOsc.kr(5);
    Out.ar(0, sig);
  }).add;

  (
    instrument: \g,
  ).play  
};

main.();
