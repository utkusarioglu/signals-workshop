{
  var digitalPins = [ 0, 1, 2, 3, 4, 5, 6, 7];
  var triggerCount = 1;

  SynthDef(\trigDetector, {
    arg ctlBus, deviceId;

    var all = Array.fill(digitalPins.size, { |i|
        DigitalIn.ar(digitalPins[i]);
    });
    
    // Convert all the bit array to a binary value
    var allId = all.reverse.reduce({ arg total, bit; total * 2 + bit }, 0);
    
    // Make sure they are set by delaying a little bit
    var delay_allId = TDelay.ar(in: allId, dur: 0.001);

    // Create bitmasks.  
    //  velMask is how many bit used for velocity
    //  devMask used for devices, of which there are only 2
    var velMask = pow(2, digitalPins.size - triggerCount) -1;
    var devMask = pow(2, triggerCount) - 1;

    // Use the masks to get the velocity and device that was activated
    var velocity = allId.bitAnd(velMask);
    var device = (allId >> (digitalPins.size - triggerCount)).bitAnd(devMask);

    // scale button between 0 and 1 based on velMask
    var button = velocity / velMask;

    // Combined this line to make it work
    var signal = Trig.ar( Select.ar(abs(device - deviceId) < 0.1, [K2A.ar(0), delay_allId * button]), 0.1);
    
    Out.ar(ctlBus, signal);
    Out.kr(ctlBus, signal);
  }).send(s);

  SynthDef("sh",{ 
    arg buf = 0, rate = 1.0, loop = 0, scale = 1.0, vol = 1.0, t_reset=0, wetBus = 0, deviceId = 0, trigBus;

    SendReply.ar(In.ar(trigBus) > 0.01, "/trg", [40, In.ar(trigBus) , buf]);
  }).send(s);

  SynthDef(\playSample, { |buf, vol = 1 |
    var snd = PlayBuf.ar(2, buf) * vol;
    var env = Env.asr(0.01, 1, 0.2).ar(doneAction: 2, gate: \gate.kr(1));
    Out.ar(\out.kr(0), snd * env);
  }).add;

  
  Task {
    s.sync;

    ~previousSampler = nil;
    ~sendFootTrigger = { | k, v |
      ~previousSampler !? {|p| p.set(\gate, 0) };   // remove old if exists
      ~previousSampler = Synth(\playSample, [\buf: k, \vol: v]); // fill with your args
    };

    ~func = OSCFunc({ 
      arg msg, time;
      
      // [time, msg].postln; 
      if(msg[2] == -1 && msg[3] == 40, { ~sendFootTrigger.value(msg[5], msg[4]) });
      },'/trg');

  }.start;
}.();
