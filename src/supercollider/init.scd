Client.setup("localhost", 57110);

s.doWhenBooted({ 
  var loader = Loader("src/supercollider");
  var defaults = loader.load("defaults.scd");
  var busses = loader.load("busses.scd").(s, defaults);

  s.freeAll;

  loader.load("synthdefs.scd").();
  loader.load("controldefs.scd").(busses);
  loader.load("routinedefs.scd").(busses);

  SpecsFile.includeDict(defaults);
  SpecsFile.includeKv(\langPort, NetAddr.langPort);
  SpecsFile.publish;
});
