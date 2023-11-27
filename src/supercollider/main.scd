Client.setup("localhost", 57110).doWhenBooted({ 
  var config = Defaults("supercollider.config.json").parse;
  var loader = Loader("src/supercollider");
  var busses = loader.load("control_busses.scd").(s, config);

  s.freeAll;

  SpecsFile.includeKv(\config, config);
  SpecsFile.includeKv(\langPort, NetAddr.langPort);

  loader.load("midi/instruments.scd");

  loader.load("osc/control.scd").(busses, config);
  loader.load("osc/instruments.scd").("piano");
  
  loader.load("synth_defs/saw3.scd");
  loader.load("synth_defs/free_verb_2_2.scd");
  loader.load("synth_defs/scamp1.scd").(
    cf: config[\busIndexes]["scamp1"][0],
    out: 3
  );

  loader.load("routine_defs.scd").(config);

  SpecsFile.publish;

  // loader.load("midi/play.scd");
});
