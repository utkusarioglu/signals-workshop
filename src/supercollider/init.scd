Client.setup("localhost", 57110);

s.doWhenBooted({ 
  var defaults = Defaults("supercollider.config.json").load;
  var loader = Loader("src/supercollider");
  var busses = loader.load("control_busses.scd").(s, defaults);

  s.freeAll;

  SpecsFile.includeKv(\controls, defaults);
  SpecsFile.includeKv(\langPort, NetAddr.langPort);

  loader.load("synth_defs.scd").();
  loader.load("control_defs.scd").(busses);
  loader.load("routine_defs.scd").(busses);

  SpecsFile.publish;
  s.scope;
});
