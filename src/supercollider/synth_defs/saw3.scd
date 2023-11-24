SynthDef(\saw3, { |
    freq, 
    out, 
    synthCf,
    spreadThreshold, 
    gate = 1
  |
  var
    sig, krs, env,
    sinSig, sinAmp, sinSpread,
    sawSig, sawAmp, sawSpread,
    atk, dec, slev, rel
  ;
  
  krs = In.kr(synthCf, 8);
  sinAmp = krs[0].linexp(0, 1, 1, 2) - 1;
  sinSpread = krs[1].linexp(0, 1, 1, spreadThreshold) - 1;

  sawAmp = krs[2].linexp(0, 1, 1, 2) - 1;
  sawSpread = krs[3].linexp(0, 1, 1, spreadThreshold) - 1;

  atk = krs[4];
  dec = krs[5];
  slev = krs[6];
  rel = krs[7];

  env = EnvGen.kr(
    envelope: Env.adsr(
      atk,
      dec,
      slev,
      rel
    ),
    gate: gate,
    doneAction: Done.freeSelf,
  );

  sinSig = Pulse.ar([
    freq, 
    freq + (sinSpread),
    freq + (sinSpread * 2),
    freq + (sinSpread * 4),
  ]) * sinAmp;

  sawSig = Saw.ar([
    freq, 
    freq + (sawSpread),
    freq + (sawSpread * 2),
    freq + (sawSpread * 4),
  ]) * sawAmp;

  sinSig = sinSig.sum / 4;

  sig = sinSig + sawSig;
  sig = sig.sum / 2;

  sig = sig * env;
  sig = sig ! 2;

  Out.ar(out, sig); 
}).add;
