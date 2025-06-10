{
  SynthDef(\thu, { 
    var 
      ins, krs,
      sig, speed, vol
    ;

    ins = In.ar(8, 1);
    krs = In.kr(0, 8);
    vol = krs[0].linexp(0, 1, 1, 11) - 1;
    speed = krs[1].linexp(0, 1, 1, 21) - 1;

    sig = 3.collect({ | i |
      var ch;

      ch = VSTPlugin.ar(ins, 1, id: 'thu' ++ i);
      ch = ch * SinOsc.kr(speed, (2 * pi * i) / 3);
      ch = ch * vol * 3.sqrt / 3;

      ch;
    });
    
    // 3.do({ | i |
    //   // sig[i] = sig[i] * SinOsc.kr(speed, (2 * pi * i) / 3);
    //   sig[i] = sig[i] * SinOsc.kr(speed, );
    // });
    Out.ar(0, sig.sum);
  }).add;

  Routine({
    if(~thu.notNil, {
      ^"Already created".postln;
    });

    "Starting routine".postln;
    1.wait;
    "Creating controller…".postln;
    ~thu = 3.collect({ | i |
      var id = 'thu' ++ i;
      id.postln;
      VSTPluginController(Synth(\thu), id: id);
    });

    3.wait;
    "Opening VSTS…".postln;
    ~thu.size.do({ | i |
      i.postln;
      ~thu[i].open("TH-U-64", editor: true, verbose: true);
    });

    3.wait;
    "Opening Editors…".postln;
    ~thu.size.do({ | i |
      i.postln;
      ~thu[i].editor;
    });
  }).play;
}.();
