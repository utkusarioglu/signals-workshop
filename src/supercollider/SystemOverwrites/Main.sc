+ Main {
  run {
    ShutDown.add {
      "SHUTDOWN COMMAND".postln;
    };

    StartUp.add {
      "STARTUP ACTION".postln;
    };

    this.handleFlags.();
  }

  handleFlags {
    var osEnv = (
      preset: "SC_PRESET".getenv,
      file: "SC_FILE".getenv,
    );

    if ([osEnv.preset, osEnv.file].select(_.notNil).size > 1) {
      Error("Cannot define both file and preset values").throw;
    };

    osEnv.preset.notNil.if({
      ("Loading preset: " ++ osEnv.preset ++ "…").postln;
      Load.preset(osEnv.preset);
    });

    osEnv.file.notNil.if({
      ("Loading file: " ++ osEnv.file ++ "…").postln;
      osEnv.file.load;
      // Load.relpath(osEnv.file);
    });
  }
}
