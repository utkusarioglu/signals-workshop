var controldefs = { | busses |
  busses.keys().do({ | key |
    OSCdef(key, {
      arg msg;

      // msg.postln;
      busses[key].setAt(msg[1], msg[2]);
    }, "/" ++ key);
  });
};

controldefs
