var action = { 
  "Opening editor".postln;
  \t.editor;
  
  OSCdef(\thu, { | msg, time, addr, recvPort |
    [msg, time, addr, recvPort].postln;
    t.set(msg[1], msg[2]);
  }, "/thu");

  ~rVstLoop = Task({
    loop {
      0.1.wait;
      ~bus2.get({ | val |
        t.set(4, val);
      })
    }
  }).play;
};

var main = {
  ~bus = Bus.control(s, 1);
  ~bus2 = Bus.control(s, 1);
  ("bus index: " + ~bus.index).postln;

  SynthDef(\thu, {
    var sig;

    sig = In.ar(8, 1);
    sig = VSTPlugin.ar(sig, 1, id: \thu);

    Out.ar(0, sig);
  }).add;

  SynthDef(\lagger, {
    var kr;

    kr = In.kr(~bus.index, 1);
    kr = Lag.kr(kr, 1);

    Out.kr(~bus2.index, kr);
  }).add;

  Routine({
    var seq, freq, vols;

    (
      \instrument: \lagger,
    ).play;

    vols = [1, 4, 2, 3];

    seq = Pseq(
      vols / vols.maxItem,
      // [1, 3, 2, 1].normalizeSum,
      inf
    ).asStream;
    
    loop{
      1.wait;
      freq = seq.next;
      // freq.postln;
      ~bus.set(freq);
    };
  }).play;

  ~rVst = Routine({
    1.wait;
    "Creating controller".postln;
    ~thu = VSTPluginController(Synth(\thu), id: \thu)
      .open("TH-U-64", editor: true, verbose: true, action: action);
  }).play;
}.();
