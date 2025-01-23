var main = {
  VSTPlugin.search { |result|
    result.do { |name, info|
        "%: %".format(name, info.path).postln;
    };
 };
}.();
