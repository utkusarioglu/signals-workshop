{
  // ~win.isNil.not.if({ ~win.close });
  Synth(\sine).free;

  SynthDef(\sine, {
    var sig, vol, semi, freq, gate, type;
    // vol = MouseY.kr(0.5, 5);
    #semi, vol, type = In.kr(~busses, 3);
    freq = (semi + 48).midicps;
    gate = (type == 0).if(0, 1);

    // env = Env(
    //   times: [0.1, 0.3, vol, vol + 1],
    //   levels: [0, 1, 0.5, 0],
    //   curve: [\linear, \linear, \linear]
    // ).ar(doneAction: 2);
    // freq = MouseX.kr(0, 24, \linear);
    // freq = (freq.round(1) + 60).midicps;
    // sig = ;
    sig = Select.ar(type / 0.5, [SinOsc.ar(freq), Saw.ar(freq) / 0.8]);
    // gate = In.kr(\gate.ir, 1);
    Out.ar(\outBus.ir, sig * vol * gate);
  }).add;

  // {
  //   var view;
  //   ~busses = Bus.control(s, 2);

  //   ~sine = Synth(\sine, [\outBus, 10]);

  //   ~win = Window("Keyboard Trigger", Rect(100, 100, 300, 100));
  //   view = UserView(~win, ~win.view.bounds); 
  //   view.keyDownAction = { |view, char, modifiers, unicode, keycode|
  //     if (char == $ ) {  // spacebar
  //       ~busses.set(1, 0);
  //       (
  //         \instrument: \sine
  //       ).play;
  //     };
  //     if(char == $a) {
  //       ~busses.set(1, 1);
  //     }
  //   };
  //   view.keyUpAction = { |view, char, modifiers, unicode, keycode|
  //     if (char == $ ) {
  //       ~busses.set(0, 0);
  //     };
  //     if(char == $a) {
  //       ~busses.set(0, 0);
  //     }
  //   };

  //   ~win.front;
  // }.();

  Task {
    s.sync;

    ~synth = Synth(\sine, [\outBus, 10, \busses, ~busses])
  }.start;
}.()
