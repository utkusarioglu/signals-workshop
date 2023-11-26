var controldefs = { | busses, config |
  config[\busOrder].do({ | key |
    MidiBridge.createControl(key, "Control");

    OSCdef(key, {
      arg msg;

      msg.postln;
      busses.setAt(
        config[\busIndexes][key][0] + msg[1],
        msg[2]
      );

      MidiBridge.updateControl(
        key, 
        config[\channels][key], 
        msg[1], 
        msg[2] * 127
      );
    }, "/" ++ key);
  });
};

controldefs
