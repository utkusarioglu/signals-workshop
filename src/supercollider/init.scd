Client.setup("localhost", 57110).doWhenBooted({ 
  var defaults = Defaults("supercollider.config.json").load;
  var loader = Loader("src/supercollider");
  var busses = loader.load("control_busses.scd").(s, defaults);

  s.freeAll;

  SpecsFile.includeKv(\controls, defaults);
  SpecsFile.includeKv(\langPort, NetAddr.langPort);

  loader.load("control_defs.scd").(busses);
  
  loader.load("synth_defs/saw3.scd");
  loader.load("synth_defs/free_verb_2_2.scd");
  loader.load("synth_defs/scamp1.scd");

  loader.load("routine_defs.scd").(busses);

  SpecsFile.publish;
});
