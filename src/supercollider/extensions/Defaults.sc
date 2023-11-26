Defaults {
  var <>jsonRelPath;

  *new { | jsonRelPath |
    ^super.newCopyArgs(jsonRelPath);
  }

  init { | jsonRelPath |
    this.jsonRelPath = jsonRelPath;
  }

  load {
    var abspath = [
      File.getcwd, 
      Platform.pathSeparator, 
      this.jsonRelPath
    ].reduce('++');
    var json = File.readAllString(abspath);
    ^JSONlib.convertToSC(json);
  }

  expand { | config |
    var parsed = Dictionary();
    var busses = Dictionary();
    var channels = Dictionary();
    var busOrder = Array(config[\controls].size);
    var start = 0;
    var end = -1;

    parsed[\raw] = config;

    config[\controls].do({ | parts, index |
      var key = parts[\symbol];
      start = end + 1;
      end = start + parts[\specs].size - 1;
      busses[key] = [start, end];
      channels[key] = index;
      busOrder.add(key);
    });

    parsed[\busses] = busses;
    parsed[\size] = end + 1;
    parsed[\channels] = channels;
    parsed[\defaults] = this.produceDefaultsArray(parsed);
    parsed[\busOrder] = busOrder;

    ^parsed;
  }

  parse {
    var raw = this.load;
    ^this.expand(raw);
  }

  produceDefaultsArray { | parsed |
    var defaults = Array(parsed[\size]);
    var ptr = 0;
    parsed[\raw][\controls].do({ | parts |
      parts[\specs].do({ | spec |
        defaults.add(spec[\default]);
      });
    })
    ^defaults;
  }
}
