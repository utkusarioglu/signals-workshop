var stockProfit1 = { | items |
  var buy, profit;

  buy = items[0];
  profit = 0;

  for(1, items.size - 1) { | i |
    var newProfit;
    if(items[i] < buy, {
      buy = items[i];
    }, {
      newProfit = items[i] - buy;
      if(newProfit > profit, {
        profit = newProfit;
      })
    });
  };

  profit;
};

var stockProfit2 = { | items |
  var total, current;

  total = 0;
  current = 0;
  
  (1..items.size - 1).do{ | i |
    current = [0, current + items[i] - items[i - 1]].maxItem;
    total = [total, current].maxItem;
  };

  total;
};

var items = [7,1,5,3,6,4];
[stockProfit1, stockProfit2].collect(_.(items)).postln; "";
