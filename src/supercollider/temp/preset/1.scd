~thuC.notNil.if({ ~thuC.close; ~thuC.free });
[~g, ~thuS, ~freezeS, ~lastS, ~thuIn, ~thuOut, ~freezeOut, ~room, ~damp, ~mix].do({ |v|
  v.notNil.if({ v.free }) 
});
~g = Group.new;

~in = 8;
~out = 0;
~thuIn = Bus.audio(s, 1);
~thuOut = Bus.audio(s, 2);
~freezeOut = Bus.audio(s, 2);
~room = Bus.control(s, 1).set(0.5);
~damp = Bus.control(s, 1).set(0.5);
~mix = Bus.control(s, 1).set(0.5);

~thuD = SynthDef(\thu, {
  var sig = In.ar(\inBus.ir, 1);
  sig = VSTPlugin.ar(sig.dup, 2, id: \thu);
  Out.ar(\outBus.ir, sig);
}).add;

~freezeD = SynthDef(\freeze, {
  var sig = In.ar(\inBus.ir, 2);
  sig = FreeVerb2.ar(sig[0], sig[1], mix: ~mix, room: ~room, damp: ~damp);
  Out.ar(\outBus.ir, sig);
}).add;

~lastS = SynthDef(\last, {
  Out.ar(\outBus.ir, In.ar(\inBus.ar, 2));
}).add;

Task {
  s.sync;
  ~lastS = Synth(\last, [\inBus, ~freezeOut, \outBus, ~out], ~g);
  ~freezeS = Synth(\freeze, [\inBus, ~thuOut, \outBus, ~freezeOut], ~g);
  ~thuS = Synth(\thu, [\inBus, ~in, \outBus, ~thuOut], ~g);

  ~thuC = VSTPluginController(~thuS, id: \thu)
    .open("TH-U-64", editor: true, verbose: true, action: _.editor);

  [~thuIn, ~thuOut, ~freezeOut].do(_.postln);
}.start
