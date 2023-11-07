s.boot;

s.waitForBoot({
  var controller;

  MIDIClient.init;
  MIDIClient.destinations;

  controller = MIDIOut.newByName("loopMIDI Control", "loopMIDI Control");

  OSCdef(\aa, {
    arg msg;

    ("val"+ msg[1]).postln;

    controller.control(
      chan: 1,
      ctlNum: 3,
      val: msg[1],
    );
    // (
    //   \type: \midi,
    //   \chan: 1,
    //   \midiout: control,
    //   \midicmd: \control,
    //   \ctlNum: 3,
    //   \midinote: msg[1]
    // ).play;
  }, "/cc");

  // OSCFunc.trace(true);
  "ready".postln;
  NetAddr.langPort.postln;
});
