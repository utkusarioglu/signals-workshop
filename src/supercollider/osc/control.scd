var controldefs = { | busses |
  MidiBridge.createController(\controls, "Controls");

  Runtime.getControlSymbols.do({ | key |
    MidiBridge.addControl(\controls, key, Runtime.getChannel(key));

    OSCdef(key, { | msg |
      // msg.postln;
      busses.setAt(Runtime.getBusIndexStart(key) + msg[1], msg[2]);
      MidiBridge.updateControl(key, msg[1], msg[2] * 127);
    }, "/" ++ key);
  });
};

controldefs
