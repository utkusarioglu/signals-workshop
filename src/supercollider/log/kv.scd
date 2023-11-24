var logKv = { | name, value, indent = 0, keyWidth = 0 |
  [
    "".padRight(indent, " "), 
    (name ++ ":").padRight(keyWidth, " "), 
    value
    ].reduce('++').postln;
};

logKv;
