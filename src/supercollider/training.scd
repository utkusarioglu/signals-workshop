
s.boot;

  
s.waitForBoot({
  var amenAbsPath = "\\\\wsl$\\u-Boulanger\\home\\utkusarioglu\\dev\\workshops\\signals-workshop\\assets\\amen.wav";

  var amen = Buffer.read(s, amenAbsPath);

  var f = {
    arg freq;
    var freq2 = freq * 2;
    freq2;
    // [freq + freq * rrand(1.0, 1.0.8), freq];
  };

  var sound = {
    arg osc;
    var freq = f.(400);
    // osc.ar(freq);
    [osc.ar(freq), osc.ar(freq)];
  };

  var thing = {
    var x = {rrand(1, 10)} ! 20;
    x.do({ |num| 
      num.asHexString(8).postln; 
    });
  };

  var plots = { |freq|
    {[SinOsc.ar(freq), SinOsc.kr(freq)]}.plot;
  };

  var g = {
    // plots.(100);
    // thing.();
    // var osc = SinOsc;
    // Out.ar(0, sound.(osc));
    PlayBuf.ar(2, amen);
  };

  g.play;
});
