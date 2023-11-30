Runtime.setConfig(JsonLoader("supercollider.config.json").load);
ScdLoader.setRelPath("src/supercollider");

Client.setup(Runtime.getHost, Runtime.getPort).doWhenBooted({ 
  var busses = ScdLoader.load("control_busses.scd").(s);

  s.freeAll;

  SpecsFile.includeDict(Runtime.getState);
  SpecsFile.includeKv('langPort', NetAddr.langPort);

  ScdLoader.load("midi/instruments.scd");

  ScdLoader.load("osc/control.scd").(busses);
  ScdLoader.load("osc/instruments.scd").("piano");
  
  ScdLoader.load("synth_defs/saw3.scd");
  ScdLoader.load("synth_defs/free_verb_2_2.scd");
  ScdLoader.load("synth_defs/scamp1.scd").(out: 3);

  ScdLoader.load("routine_defs.scd").();

  SpecsFile.write;
  SpecsFile.log;

  // ScdLoader.load("midi/play.scd");
});
