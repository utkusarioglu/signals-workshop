
s.boot;

s.waitForBoot({
  var f = {
    arg freq;
    freq * 2;
  };

  var sound = {
    arg osc;
    var freq = f.(200);
    [osc.ar(freq), LFPar.ar(freq)];
  };

  var g = {
    Out.ar(0, sound.(LFPulse));
  };

  g.play;
});
