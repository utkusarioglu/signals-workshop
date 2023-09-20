
// (
//   s.waitForBoot {
//     f = { 
//       var freq = 440;
//       var amp = 0.5;
//       // var amp = SinOsc.ar(0.5, 0, 10, 0.5);
//       [
//         SinOsc.ar(freq, 0, amp) + SinOsc.ar(freq * 2, 0, amp),
//         SinOsc.ar(freq, 0, amp) + SinOsc.ar(freq * 2, 0, amp)
//       ] };
//     f.plot;
//     f.play;
//   };
// );

// (
//   s.waitForBoot {
//     ScampUtils.instrumentFromSynthDef(
//       SynthDef(\superInst, ( | freq=440, volume=0, gate=1, crackliness=0, spread=0, pan=0 |
//         var synth = Mix.fill(5, { |k| 
//           Pan2.ar(
//             SinOsc.ar(
//               freq * spread.linlin(0, 1, 1.0, 0.8).pow(k-2) * LFNoise1.ar(
//                 crackliness.linlin(0, 1, 30, 100), 
//                 crackliness.linlin(0, 1, 0, 0.2), 
//                 1
//               ),
//               crackliness.linlin(0, 1, 1, 300)
//             ) * EnvGen.kr(Env.perc(
//               attackTime: crackliness.linexp(0, 1, 0.02, 0.01),
//               releaseTime: crackliness.linlin(0, 1, 0.2, 0.01)
//             ),
//               gate: Impulse.kr(40)),
//               k.linlin(0,5,-1, 1)
//           )
//         });
//         var panned_out = volume * synth * EnvGen.ar(Env.adsr, gate: gate, doneAction: 2) * Pan2.ar(DC.ar(1), pan);
//         Out.ar(0, panned_out);
//       ))
//     )};
// )
s.boot;
s.waitForBoot {
/* Retrieved from
http://sccode.org/1-5aD
Reed Organ Simulation
Original by Nathan Ho aka Snappizz
http://sccode.org/1-51m
Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("organReed", {
    arg
	//Standard Values
	out = 0, pan = 0, freq = 440, amp = 0.3, gate = 1, att = 0.3, rel = 0.3,
	//Depth and Rate Controls (pwmDepth and amDepth range from 0 to 1)
	ranDepth = 0.04, pwmRate = 0.06, pwmDepth = 0.1, amDepth = 0.05, amRate = 5,
	//Other Controls
	nyquist = 18000, fHarmonic = 0.82, fFreq = 2442, rq = 0.3, hiFreq = 1200, hirs = 1, hidb = 1;

    var snd, env;

	// The same envelope controls both the resonant freq and the amplitude
    env = Env.asr(
		attackTime: att,
		sustainLevel: amp,
		releaseTime: rel).ar(gate: gate, doneAction: 2);

    // pulse with modulating width
	snd = Pulse.ar(
		freq: TRand.ar(lo: 2.pow(-1 * ranDepth), hi: 2.pow(ranDepth), trig: gate) * freq,
		width: LFNoise1.kr(freq: pwmRate, mul: pwmDepth).range(0, 1)1,
		mul: 0.0625);  //Incereasing this lessens the impact of the BPF

    // add a little "grit" to the reed
    //original used snd = Disintegrator.ar(snd, 0.5, 0.7);
	snd = Latch.ar(snd, Impulse.ar(nyquist * 2));

    // a little ebb and flow in volume
	snd = snd * LFNoise2.kr(freq: amRate).range((1 - amDepth), 1);

	//Filtering (BHiShelf intensifies the buzzing)
	snd = snd + BPF.ar(in: snd, freq: env.linexp(0, amp, fFreq * fHarmonic, fFreq), rq: rq);
    snd = BHiShelf.ar(in: snd, freq: hiFreq, rs: hirs, db: hidb);

	//Output
	snd = Mix.ar(snd * env);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Nathan Ho aka Snappizz",
	category: \organ,
	tags: [\pitched, \tom, \sos]
	)
).add;
}
