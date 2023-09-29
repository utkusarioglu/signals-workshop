s.boot;

s.waitForBoot({
  SynthDef("tutorial-Infreq", { arg bus, freqOffset = 0, out;
      // this will add freqOffset to whatever is read in from the bus
      Out.ar(out, SinOsc.ar(In.kr(bus) + freqOffset, 0, 0.5));
  }).add;
  s.sync();

  SynthDef("tutorial-Outfreq", { arg freq = 400, bus;
      Out.kr(bus, SinOsc.kr(1, 0, freq/40, freq));
  }).add;
  s.sync();

  b = Bus.control(s,1);
  s.sync();

  x = Synth.new("tutorial-Outfreq", [\bus, b]);
  y = Synth.after(x, "tutorial-Infreq", [\bus, b]);
  z = Synth.after(x, "tutorial-Infreq", [\bus, b, \freqOffset, 200]);
  s.sync();

  // x.free; y.free; z.free; b.free;
})
