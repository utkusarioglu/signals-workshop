var controldefs = { | busses, config |
  MidiBridge.createController(\controls, "Controls");

  config[\busOrder].do({ | key |
    MidiBridge.addControl(\controls, key, config[\channels][key]);

    OSCdef(key, {
      arg msg;

      // msg.postln;

      busses.setAt(
        config[\busIndexes][key][0] + msg[1],
        msg[2]
      );

      MidiBridge.updateControl(
        key,
        msg[1],
        msg[2] * 127
      );
    }, "/" ++ key);
  });
};

controldefs
