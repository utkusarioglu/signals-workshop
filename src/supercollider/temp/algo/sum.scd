var maxSubarraySum = { | items |
  var total, current;

  total = items[0];
  current = items[0];

  (1..items.size - 1).do{ | i |
    current = [items[i], current + items[i]].maxItem;
    total = [current, total].maxItem;
  };

  total;
};

maxSubarraySum.([-2, 1, -3, 4, -1, 2, 1, -5, 4]).postln;
