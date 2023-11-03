s.boot;

s.waitForBoot({

  OSCdef(\aa, {
    arg msg;
    ().play;
  }, "/aa");

  // OSCFunc.trace(true);
  "ready".postln;
  NetAddr.langPort.postln;
});
