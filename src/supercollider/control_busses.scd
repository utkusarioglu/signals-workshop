var loader = Loader("src/supercollider");
var logKv = loader.load("log/kv.scd");

var publishAssignments = { | config |
  "Control bus assignments:".postln;

  config[\busOrder].do({ | key |
    var range = config[\busIndexes][key].collect({ | val |
      val.asString.padLeft(4, " ");
    }).reduce('+');
    range = range + config[\channels][key];
    logKv.(key, range, 2, 8);
  });
};

var busses = { | server, config |
  var busIndexes = Dictionary();
  var busses = Bus.control(server, config[\defaults].size);
  busses.setn(config[\defaults]);
  
  config[\busOrder].do({ | key |
    busIndexes[key] = config[\busses][key].collect({ | ptr |
      ptr + busses.index;
    })
  });

  config[\busIndexes] = busIndexes;
  publishAssignments.(config);

  busses;
};

busses;
