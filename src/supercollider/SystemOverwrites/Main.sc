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

    
    // if(thisProcess.argv.size > 0) {
    //   if(thisProcess.argv[0] == "--preset") {
    //     Load.preset(thisProcess.argv[1]);
    //   } {
    //     Error("Unrecognized custom flag: %".format(thisProcess.argv[0])).throw;
    //   };
    // };

  }
}
