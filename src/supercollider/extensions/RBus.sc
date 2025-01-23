RBus : Bus {

  control{ | server, numChannels, name |
    var bus = super.control(server, numChannels);
    ("Creating" + numChannels + "busses with name" + name.asString).postln

    ^bus;
  }

  set{ | ...values |
    values.postln;
    ^super.set(*values);
  }
}
