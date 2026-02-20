~bus = Dictionary[
  \coords -> Bus.control(s, 3);
];

OSCdef(\coordinates, { | msg |
  var alpha, beta, gamma;
  #alpha, beta, gamma = msg.drop(1).collect(_.asInteger);
  alpha = alpha.linlin(0, 360 - 1 , -1, 1);
  beta = beta.linlin(-180, 180 - 1, -1, 1);
  gamma = gamma.linlin(-90, 90 - 1, -1, 1);
  ~bus[\coords].set(alpha, beta, gamma);
}, "/coordinates").add;

SynthDef(\basic, {
  var sig, freq1, freq2, freq3;

  #freq1, freq2, freq3 = In.kr(~bus[\coords], 3);
  
  sig = [
    SinOsc.ar(freq1.linexp(-1, 1, 20, 2000)), 
    Saw.ar(freq2.linexp(-1, 1, 200, 5000)), 
    Pulse.ar(freq3.linexp(-1, 1, 2000, 10000)), 
  ].normalizeSum;

  Out.ar(0, sig);
}).add;
