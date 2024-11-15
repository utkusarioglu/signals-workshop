Runtime.setConfig(JsonLoader("supercollider.config.json").load);
Load.setRelPath("src/supercollider");

Client.setup(Runtime.getHost, Runtime.getPort).doWhenBooted({ 
  var busses = Load.path("control_busses.scd").(s);

  s.freeAll(true);
  // s.latency = 0.12;

  SpecsFile.includeDict(Runtime.getState);
  SpecsFile.includeKv('langPort', NetAddr.langPort);

  Load.path("midi/instruments.scd");

  Load.path("osc/control.scd").(busses);
  Load.path("osc/instruments.scd").("piano");
  
  Load.path("synth_defs/saw3.scd");
  Load.path("synth_defs/free_verb_2_2.scd");
  Load.path("synth_defs/guitar1.scd");
  Load.path("synth_defs/scamp1.scd").(out: 3);

  Load.path("routine_defs.scd").();

  SpecsFile.write;
  SpecsFile.postReady;
});
