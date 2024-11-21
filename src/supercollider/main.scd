Runtime.setConfig(JsonLoader("sc.config.json").load);
Load.setRelPath("src", "supercollider");

Client.setup(Runtime.getHost, Runtime.getPort).doWhenBooted({ 
  var busses = Load.scd("control_busses").(s);

  s.freeAll(true);
  // s.latency = 0.12;

  SpecsFile.includeDict(Runtime.getState);
  SpecsFile.includeKv(\langPort, NetAddr.langPort);

  Load.scd("midi", "instruments");

  Load.scd("osc", "control").(busses);
  Load.scd("osc", "instruments").("piano");
  
  Load.scd("synth_defs", "saw3");
  Load.scd("synth_defs", "free_verb_2_2");
  Load.scd("synth_defs", "guitar1");
  Load.scd("synth_defs", "scamp1").(out: 3);

  Load.scd("routine_defs").();

  SpecsFile.write;
  SpecsFile.postReady;
});
