var publishAssignments = { | controlBusses |
  "Control bus assignments:".postln;

  controlBusses.keys().do({ | key |
    [
      "  ", 
      key, 
      ": ", 
      controlBusses[key].index
    ].reduce('++').postln;
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
