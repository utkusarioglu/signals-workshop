[
"JSONlib",
"ScampUtils",
"https://github.com/Spacechild1/vstplugin.git"
].do({ |name| Quarks.install(name); });

Specs.setFile(Path.fromRepoRoot("artifacts/scd_runtime.json"));
Runtime.setConfig(Json.load(Path.fromRepoRoot("sc.config.json")));

Client
  .setup(Runtime.getHost, Runtime.getPort)
  // .doWhenBooted(Load.relpath("workspace"));
  .doWhenBooted({
    // ~busses = Load.relpath("control_busses").(s);

    s.freeAll(true);
    // s.latency = 0.12;

    Specs.includeDict(Runtime.getState);
    Specs.includeKv(\langPort, NetAddr.langPort);

    // Load.relpath("midi/instruments");

    // Load.relpath("osc/control").(~busses);
    // Load.relpath("osc/instruments").("piano");
    
    // Load.relpath("synth_defs/saw3");
    // Load.relpath("synth_defs/free_verb_2_2");
    // Load.relpath("synth_defs/guitar1");
    // Load.relpath("synth_defs/scamp1").(out: 0);

    // Load.relpath("routine_defs").();

    // if(thisProcess.argv.size > 0) {
    //   if(thisProcess.argv[0] == "--preset") {
    //     Load.preset(thisProcess.argv[1]);
    //   } {
    //     Error("Unrecognized custom flag: %".format(thisProcess.argv[0])).throw;
    //   };
    // };

    Specs.write;
    Runtime.ready;
  });
