var busses = { | server, defaults |
  var dict = Dictionary();
  var defaultValues = Dictionary();

  defaultValues = defaults.collect({ |parts|
    parts.collect({ |items|
      items[\default];
    });
  });

  defaults.keys().do({ |key|
    dict[key] = Bus.control(server, defaults[key].size);
    dict[key].setn(defaultValues[key]);
  });

  "Control bus assignments:".postln;
  dict.keys().do({ | key |
    (key ++ ":" + dict[key].index).postln;
  });

  dict;
};

busses;
