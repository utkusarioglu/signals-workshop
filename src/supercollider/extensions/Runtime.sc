Runtime {
  classvar state;
  classvar config;

  *new { | config |
    ^super.newCopyArgs(config);
  }

  *initClass {
    state = Dictionary();
    config = Dictionary();
  }

  *setConfig { | rawConfig |
    config = rawConfig;
    state = ConfigParser.parse(rawConfig);
  }

  *loadFromSpecs { 
    var specsFile = Specs.read;
    state = specsFile;
    config = specsFile[\config];
  }

  *defaults {
    ^state[\defaults];
  }

  *setBusIndexes { | startIndex |
    var busIndexes = Dictionary();
    state[\busOrder].do({ | key |
      busIndexes[key] = state[\busses][key].collect({ | ptr |
        ptr + startIndex;
      })
    });
    state[\busIndexes] = busIndexes;
  }

  *getState {
    ^state;
  }

  *getConfig {
    ^config;
  }

  *getControlSymbols {
    ^state[\busOrder];
  }

  *getChannel { | key |
    ^state[\channels][key];
  }

  *getBusIndexStart { | key |
    ^state[\busIndexes][key][0];
  }

  *getBusLength { | key |
    var busRange = state[\busses][key];
    var length = busRange[1] - busRange[0] + 1;
    ^length;
  }

  *getHost {
    ^config[\connection][\host];
  }

  *getPort {
    ^config[\connection][\port];
  }

  *ready {
    [
      "Client connected to '", 
      Runtime.getHost,
      // all[\config][\connection][\host], 
      ":", 
      Runtime.getPort,
      // all[\config][\connection][\port], 
      "'."
    ].reduce('++').postln;

    "Sclang ready.".postln;
  }
}
