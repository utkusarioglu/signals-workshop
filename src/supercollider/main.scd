// Quarks.folder(".quarks");
Quarks.install("JSONlib");
Quarks.install("ScampUtils");
Quarks.install("https://github.com/Spacechild1/vstplugin.git");

Specs.setFile(Path.fromRepoRoot("artifacts/scd_runtime.json"));
Runtime.setConfig(Json.load(Path.fromRepoRoot("sc.config.json")));

Client
  .setup(Runtime.getHost, Runtime.getPort)
  // .doWhenBooted(Load.scd("workspace"));
  .doWhenBooted({
    // ~busses = Load.scd("control_busses").(s);

    s.freeAll(true);
    // s.latency = 0.12;

    Specs.includeDict(Runtime.getState);
    Specs.includeKv(\langPort, NetAddr.langPort);

    // Load.scd("midi/instruments");

    // Load.scd("osc/control").(~busses);
    // Load.scd("osc/instruments").("piano");
    
    // Load.scd("synth_defs/saw3");
    // Load.scd("synth_defs/free_verb_2_2");
    // Load.scd("synth_defs/guitar1");
    // Load.scd("synth_defs/scamp1").(out: 0);

    // Load.scd("routine_defs").();

    if(thisProcess.argv.size > 0) {
      if(thisProcess.argv[0] == "--preset") {
        Load.preset(thisProcess.argv[1]);
      } {
        Error("Unrecognized custom flag: %".format(thisProcess.argv[0])).throw;
      };
    };

    Specs.write;
    Runtime.ready;
  });
