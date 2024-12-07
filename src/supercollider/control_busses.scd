var logKv = Load.scd("log", "kv");

var busses = { | server, config |
  var busses = Bus.control(server, Runtime.defaults.size);
  busses.setn(Runtime.defaults);
  
  Runtime.setBusIndexes(busses.index);

  busses;
};

busses;
