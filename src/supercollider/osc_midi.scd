o = ServerOptions.new;
o.protocol_(\tcp);
s = Server.remote(\remote, NetAddr("localhost", 57110), o); // set to correct address and port
s.addr.connect;
Server.default = s;

s.doWhenBooted({
  var controller;

  MIDIClient.init;
  MIDIClient.destinations;

  controller = MIDIOut.newByName("loopMIDI Control", "loopMIDI Control");

  OSCdef(\aa, {
    arg msg;

    msg.postln;

    controller.control(
      chan: 1,
      ctlNum: msg[1],
      val: msg[2],
    );

  }, "/cc");

  // OSCFunc.trace(true);
  NetAddr.langPort.postln;
});
