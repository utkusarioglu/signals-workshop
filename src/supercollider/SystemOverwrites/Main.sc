+ Main {
  run {
    ShutDown.add {
      "SHUTDOWN COMMAND".postln;
    };

    StartUp.add {
      "STARTUP ACTION".postln;
    };

    "Running 'main'…".postln;
    Load.scd("main");
  }
}
