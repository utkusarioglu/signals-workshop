var controldefs = { | busses |
  MidiBridge.createController(\controls, "Controls");

  Config.getControlSymbols.do({ | key |
    MidiBridge.addControl(\controls, key, Config.getChannel(key));

    OSCdef(key, { | msg |
      // msg.postln;
      busses.setAt(Config.getBusIndexStart(key) + msg[1], msg[2]);
      MidiBridge.updateControl(key, msg[1], msg[2] * 127);
    }, "/" ++ key);
  });
};

controldefs
