var pBass, pAll, qAll;
var kick, snare, openHihat, pDrums, closedHihat;

pAll = [];
pBass = [];
pDrums = [];
qAll = [];
kick = 36;
snare = 39;
closedHihat = 62;
openHihat = 60;

pBass = pBass.add(Pbind(
  \type, \midi,
  \chan, 1,
  \midiout, MidiBridge.getInstrument("bass"),
  \midicmd, \noteOn,
  // \midinote, Pwhite(60, 72, inf),
  \midinote, Pseq([0, 3, 7, 12, 15] + 48,inf),
  \amp, Pseq([0.9, 0.5, 0.6], inf),
  \sustain, 1/4,
  \dur, 1/4,
));

pDrums = pDrums.add(Pbind(
  \type, \midi,
  \chan, 10,
  \midiout, MidiBridge.getInstrument("drums"),
  \midicmd, \noteOn,
  \midinote, Pseq([1, 0] * kick, inf),
  \amp, Pn(Pseq([0.7, 0.6], 8), inf),
  \sustain, 0.1,
  \dur, 1/2,
));

pDrums = pDrums.add(Pbind(
  \type, \midi,
  \chan, 10,
  \midiout, MidiBridge.getInstrument("drums"),
  \midicmd, \noteOn,
  \midinote, Pseq([0, 1] * snare, inf),
  \amp, Pn(Pseq([0.8, 0.5], 8), inf),
  \sustain, 0.1,
  \dur, 1/2,
));

pDrums = pDrums.add(Pbind(
  \type, \midi,
  \chan, 10,
  \midiout, MidiBridge.getInstrument("drums"),
  \midicmd, \noteOn,
  \midinote, Pseq([closedHihat, openHihat], inf),
  \amp, Pn(Pseq([0.6, 0.4], 8), inf),
  \sustain, 0.1,
  \dur, 1/4,
));

pAll = pBass ++ pDrums;

pAll.do({
  arg p;
  qAll = qAll.add(p.play);
});
// wait(60);
// qAll.do({
//   arg q;
//   q.stop;
// });
