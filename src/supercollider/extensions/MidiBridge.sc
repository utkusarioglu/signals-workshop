MidiBridge {
  classvar prefix;
  classvar instruments;
  classvar controls;
  classvar controllers;
  
  *initClass {
    prefix = "loopMIDI ";
    instruments = Dictionary();
    controls = Dictionary();
    controllers = Dictionary();

    MIDIClient.init;
    // MIDIClient.destinations;
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

  *createController { | key, bridge |
    var portName = prefix ++ bridge;
    controllers[key] = MIDIOut.newByName(portName, portName);
  }

  *addControl { | controllerId, busId, midiChannel |
    controls[busId] = (
      controllerId: controllerId,
      midiChannel: midiChannel
    );
  }

  *updateControl { | key, ctlNum, val |
    var control = controls[key];

    controllers[control[\controllerId]].control(
      chan: control[\midiChannel],
      ctlNum: ctlNum,
      val: val
    );
  }
}
