// This file follows this course:
// https://www.youtube.com/watch?v=Ng2OSh8bqJE
// Note that the midi in related code hasn't been tested as
// I don't have a midi input device readily available at the time 
// of writing this; expect errors.

s.boot;

s.waitForBoot({
  var synthDefs, midiIn, cfBus;
  
  cfBus = Bus.control(s, 1);

  synthDefs = {
    SynthDef(\saw, {
      var sig, env;
      var freq, rq, gate, amp, out, width, cf, cfBus;
    
      width = \width.ir(2);
      freq = \freq.kr(440);
      cfBus = \cfBus.ir(0);
      rq = \rq.kr(0.4);
      gate = \gate.kr(1);
      amp = \amp.kr(0.25);
      out = \out.kr(0);

      cf = In.kr(cfBus, 1).linlin(0, 1, 50, 5000);

      sig = Saw.ar(freq, * { Rand(-1 * width, width).midiratio }.dup(4));
      sig = Splay.ar(sig);
      sig = RLPF.ar(sig, cf, rq);
      env = Env.adsr().kr(Done.freeSelf, gate);
      sig = sig * env * amp;
      
      Out.ar(out, sig);
    }).add;
  };

  midiIn = {
    var notes, vol, cfBus;

    vol = 0.2;
    notes = nil ! 128;

    MIDIClient.init;
    MIDIIn.connectAll;
    MIDIFunc.trace(true);
    "done".postln;
    
    
    MIDIdef.noteOn(\on, {
      arg vel, pitch, chan, src;

      [vel, pitch, chan, src].postln;
      
      notes[pitch] = Synth(\saw, [
        freq: pitch.midicps,
        amp: vel.linexp(0, 127, 0.1, 1) * vol,
        cfBus: cfBus
      ])
    });

    MIDIdef.noteOff(\off, {
      arg vel, pitch, chan, src;

      [pitch, chan, src].postln;
      
      notes[pitch].set(\gate, 0);
    });

    MIDIdef.cc(\cf, {
      arg vel, pitch, chan, src;
      cfBus.value_(vel.linexp(0, 127, 0, 1));
    }, ccNum: 22)

    // MIDIDef(\on).disable;
    // MIDIDef(\on).enable;
  };



  synthDefs.();
  wait(1);
  midiIn.();
});
