var mergeRange = { | arr, li, mi, ri |
  var lRng = mi - li + 1;
  var rRng = ri - mi;
  var lArr = arr[li..mi].copy;
  var rArr = arr[(mi + 1)..ri].copy;

  var l = 0;
  var r = 0;
  var a = li;
  while { (l < lRng) && (r < rRng) } {
    if( lArr[l] < rArr[r]) {
      arr[a] = lArr[l];
      l = l + 1;
      a = a + 1;
    } {
      arr[a] = rArr[r];
      a = a + 1;
      r = r + 1;
    };
  };

  while {l < lRng} {
    arr[a] = lArr[l];
    l = l + 1;
    a = a + 1;
  };

  while {r < rRng} {
    arr[a] = rArr[r];
    r = r + 1;
    a = a + 1;
  }
};

var sortRange = { | arr, li, ri |
  (li < ri).if({
    var mi = li + (ri - li).div(2);

    sortRange.(arr, li, mi);
    sortRange.(arr, mi + 1, ri);
    mergeRange.(arr, li, mi, ri);
  });
};

var mergeSort = { | input |
  var sorted = input.copy();
  sortRange.(sorted, 0, sorted.size - 1);
  sorted;
};

10.do{ | i |
  var input = (1..i).scramble;
  input.postln;
  mergeSort.(input).postln;
};

0.exit;

// var mergeSort = { |arr|
// 	var merge;
// 	merge = { |left, right|
// 		if (left.isEmpty) { ^right };
// 		if (right.isEmpty) { ^left };

// 		if (left[0] <= right[0]) {
// 			^[ [left[0]] ++ merge.(left.copyRange(1, left.size-1), right) ];
// 		} {
// 			^[ [right[0]] ++ merge.(left, right.copyRange(1, right.size-1)) ];
// 		}
// 	};

// 	if (arr.size <= 1) {
// 		^arr.copy;
// 	};

// 	var mid = arr.size div: 2;
// 	var left = arr.copyRange(0, mid - 1);
// 	var right = arr.copyRange(mid, arr.size - 1);
// 	^merge.(mergeSort.(left), mergeSort.(right));
// };
