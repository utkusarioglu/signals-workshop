MidiBridge {
  classvar prefix;
  classvar instruments;
  classvar controls;
  
  *initClass {
    prefix = "loopMIDI ";
    instruments = Dictionary();
    controls = Dictionary();

    MIDIClient.init;
    MIDIClient.destinations;
  }
  
  *silenceAll {
    instruments.do({ | port |
      (0..127).do({
        arg note;
        (
          type: \midi,
          midiout: port,
          midicmd: \noteOff,
          midinote: note,
        ).play;
      });
    });
  }

  *createInstrument { | key, bridge |
    var portName = prefix ++ bridge;
    instruments[key] = MIDIOut.newByName(portName, portName);
  }

  *getInstrument { | key |
    ^instruments[key];
  }

  *createControl { | key, bridge |
    var portName = prefix ++ bridge;
    var controller = MIDIOut.newByName(portName, portName);

    controls[key] = controller;
  }

  *updateControl { | key, chan, ctlNum, val |
    var controller = controls[key];

    controller.control(
      chan: chan,
      ctlNum: ctlNum,
      val: val
    );
  }
}
