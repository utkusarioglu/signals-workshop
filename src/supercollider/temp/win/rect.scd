// (
var win, view;
var width = 1000;
var height = 400;
var numRects = 24;
var rects = Array.new(numRects);
var colorStr = "wbwbwwbwwbwb";
var mousePos = Point(0, 0);
var colors = colorStr.as(Array).collect(_ == $w).collect(_.if(Color.white, Color.black));


~win.isNil.not.if({~win.close});
~busses.isNil.not.if({ ~busses.free });

~busses = Bus.control(s, 3);
~win = Window("24 Rectangles", Rect(200, 500, width, height)).front;

view = UserView(~win, ~win.view.bounds)
    .resize_(5)
    .drawFunc_({
        var w = view.bounds.width;
        var h = view.bounds.height;
        var rectWidth = w / numRects;

        Pen.fillColor = Color.gray;
        Pen.fillRect(view.bounds); // Clear background

        numRects.do { | i |
            var x = i * rectWidth;
            var r = Rect(x, 0, rectWidth - 2, h);
            Pen.fillColor = colors[i%12];
            Pen.fillRect(r);

        };
    });

view.mouseMoveAction_({ |v, x, y, mod, buttons|
  var semi = (x / width * numRects).floor;
  var amp = (height - y) / height;
  ~busses.setAt(0, semi);
  ~busses.setAt(1, amp);
});

view.mouseDownAction_({ | v, x, y, m, b |
  var semi = (x / width * numRects).floor;
  ~busses.setAt(0, semi);
  ~busses.setAt(2, (b + 1)/2);
});

view.mouseUpAction_({ | v |
  ~busses.setAt(2, 0);
});
// )
