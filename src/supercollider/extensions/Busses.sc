Busses {
  // *create_old {
  //   arg s, defaults;
  //   var busses;

  //   busses = Bus.control(s, 8);
  //   busses.setn(defaults);

  //   busses.index.postln;

  //   ^busses;
  // }
  classvar busNames;
  classvar busses;
  classvar server;
  
  // *new {
  //  }
  
  *new {
    arg serverInstance;

    busNames = Dictionary();
    server = serverInstance;

    ^super.newCopyArgs(serverInstance);
  }

  create {
    arg specs;

    var defaults;

    defaults = Array.new(specs.size);
    // names = Array.new(specs.size);

    busses = Bus.control(server, specs.size);

    specs.do({
      arg val, i ;
      defaults = defaults.insert(i, val.default);
      busNames.put(val.name, i);
      // names = names.insert(i, val.name);
    });


    defaults.postln;
    busNames.postln;
    // names.postln;
    
    ^defaults;
  }

  get {
    arg busName;

    // ^In.kr(busses, busNames[busName]);
    ^In.kr(busses, busses.size)[busNames[busName]];
  }
}
