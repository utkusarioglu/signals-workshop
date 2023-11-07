o = ServerOptions.new;
o.protocol_(\tcp);
s = Server.remote(\remote, NetAddr("localhost", 57110), o); // set to correct address and port
s.addr.connect;
Server.default = s;

s.doWhenBooted({ 
  var synthDefs;

  // s.freeAll;

  synthDefs = {
    
    SynthDef(\saw3, {
      arg freq, amp, out;
      var sig;

      sig = SinOsc.ar(freq) * amp;

      Out.ar(out, sig); 
    }).add;
    "synthdef registered".postln;
  };
  
  synthDefs.();
});
