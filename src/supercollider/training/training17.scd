s.boot;

s.scope;

s.waitForBoot({
  arg freqBus, volumeBus, divergenceBus;
  var createGui, createSynthDefs;

  freqBus = Bus.control(s, 1);
  volumeBus = Bus.control(s, 1);
  divergenceBus = Bus.control(s, 1);

  createSynthDefs = {
    SynthDef(\saw, {
      arg freqBus, volumeBus;
      var sig, freq, volume, out, divergence, divergenceVec;

      out = \out.ir(0);
      freq = In.kr(freqBus, 1).linexp(0, 1, 20, 20000).lag(0.1);
      volume = In.kr(volumeBus, 1).lag(0.1);
      divergence = In.kr(divergenceBus, 1).lag(0.1);

      divergenceVec = [
        0,
        divergence,
        divergence * 3,
        divergence * 7
      ] + 1;

      sig = SinOsc.ar(freq * divergenceVec);
      sig = sig * volume / divergenceVec.size;

      Out.ar(out, sig ! 2);
    }).add;
  };

  createGui = {
    var window, sliders, knobs, slider2d;

    window = Window.new("Hello", Rect(
      (Window.screenBounds.width - 800) / 2,
      (Window.screenBounds.height - 600) / 2,
      800, 
      600
    ));
    sliders = 8.collect({Slider.new()});
    sliders[0].action = {
      arg s;
      divergenceBus.value_(s.value);
    };
    knobs = 8.collect({Knob.new()});
    slider2d = Slider2D.new();
    slider2d.action = {
      arg s;

      freqBus.value_(s.value.x);
      volumeBus.value_(s.value.y);
    };

    // knob = Knob.new(window);
    window.layout_(
      VLayout(
        HLayout(*sliders),
        HLayout(*knobs),
        slider2d
      )
    );

    window.front;
  };

  createGui.();
  createSynthDefs.();
  wait(1);

  (
    \instrument: \saw,
    freqBus: freqBus,
    volumeBus: volumeBus,
    divergenceBus: divergenceBus,
    arBus: 0,
  ).play;
});
