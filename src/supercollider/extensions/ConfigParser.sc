ConfigParser {
  *parse { | config |
    var parsed = Dictionary();
    var busses = Dictionary();
    var channels = Dictionary();
    var titles = Dictionary();
    var busOrder = Array(config[\controls].size);
    var start = 0;
    var end = -1;

    parsed[\config] = config;

    config[\controls].do({ | parts, index |
      var key = parts[\symbol];
      start = end + 1;
      end = start + parts[\specs].size - 1;
      busses[key] = [start, end];
      channels[key] = index;
      busOrder.add(key);
      titles[key] = parts[\title]
    });

    parsed[\busses] = busses;
    parsed[\size] = end + 1;
    parsed[\channels] = channels;
    parsed[\defaults] = this.produceDefaultsArray(parsed);
    parsed[\busOrder] = busOrder;
    parsed[\titles] = titles;

    ^parsed;
  }

  *produceDefaultsArray { | parsed |
    var defaults = Array(parsed[\size]);
    var ptr = 0;
    parsed[\config][\controls].do({ | parts |
      parts[\specs].do({ | spec |
        defaults.add(spec[\default]);
      });
    })
    ^defaults;
  }
}
