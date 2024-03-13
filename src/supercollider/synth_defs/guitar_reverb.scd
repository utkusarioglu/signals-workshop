SynthDef(\GuitarReverb, { 
  |
    out,
    in
  |
  var inSig, outSig, krs, mix, room, damp, amp;

  inSig = In.ar(in, 2);
  krs = In.kr(
    Runtime.getBusIndexStart("guitarReverb"), 
    Runtime.getBusLength("guitarReverb")
  );

  amp = krs[0];
  mix = krs[1];
  room = krs[2];
  damp = krs[3];

  outSig = FreeVerb2.ar(
      inSig[0],
      inSig[1],
      mix, room, damp, amp
  );

  Out.ar(out, outSig);
}).add;
