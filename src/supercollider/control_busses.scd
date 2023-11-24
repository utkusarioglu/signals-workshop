var loader = Loader("src/supercollider");
var logKv = loader.load("log/kv.scd");

var publishAssignments = { | controlBusses |
  "Control bus assignments:".postln;

  controlBusses.keys().do({ | key |
    logKv.(key, controlBusses[key].index, 2, 8);
  });
};

var getDefaultValues = { | defaults |
   defaults.collect({ |parts|
    parts.collect({ |items|
      items[\default];
    });
  });
};

var busses = { | server, defaults |
  var controlBusses = Dictionary();
  var defaultValues = getDefaultValues.(defaults);

  defaults.keys().do({ |key|
    controlBusses[key] = Bus.control(server, defaults[key].size);
    controlBusses[key].setn(defaultValues[key]);
  });

  publishAssignments.(controlBusses);

  controlBusses;
};

busses;
