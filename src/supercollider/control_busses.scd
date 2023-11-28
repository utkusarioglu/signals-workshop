var logKv = ScdLoader.load("log/kv.scd");

// var publishAssignments = { | config |
//   "Control assignments:".postln;

//   config[\busOrder].do({ | key |
//     var range = config[\busIndexes][key].collect({ | val |
//       val.asString.padLeft(4, " ");
//     }).reduce('+');
//     range = range + config[\channels][key].asString;
//     logKv.(key, range, 2, 8);
//   });
// };

var busses = { | server, config |
  var busses = Bus.control(server, Config.defaults.size);
  busses.setn(Config.defaults);
  
  // config[\busOrder].do({ | key |
  //   busIndexes[key] = config[\busses][key].collect({ | ptr |
  //     ptr + busses.index;
  //   })
  // });

  // publishAssignments.(config);
  
  Config.setBusIndexes(busses.index);

  busses;
};

busses;
