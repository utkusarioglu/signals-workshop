var combSum4dyn = { | nums, target |
  var dp = 0.dup(target + 1);
  dp[0] = 1;

  (1..target).do{ | t |
    dp[t] = nums
      .collect{ | n |
        (t >= n).if(dp[t - n], 0);
      }
      .sum;
  };

  dp[target];
};

var combSum4rec = { | nums, target |
  var helper;
  var memo = Dictionary.new;
  nums = nums.sort;
  memo[0] = 1;

  helper = { | t |
    var r = memo[t];
    r = r.isNil.if({ t < nums[0] }, false).if(0, r);
    r.isNil.if({
      memo[t] = nums
          .select(t >= _)
          .collect{ |n| helper.(t - n) }
          .sum; 
      memo[t];
    }, r);
  };
  helper.(target);
};


combSum4dyn.([9], 3).postln;
combSum4dyn.([1,2,3], 4).postln;
"-".postln;
combSum4rec.([9], 3).postln;
combSum4rec.([1,2,3], 4).postln;

// 0.exit;
