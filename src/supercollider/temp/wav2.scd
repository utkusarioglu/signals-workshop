r = Routine({
  var filePath;

  filePath = ["assets", "wav", "sonic-pi", "ambi-choir.wav"].reduce('+/+');
  if(
    File.exists(filePath).not
    {}
    {[filePath, " does not exist"].reduce('++').postln}
  );
  b = Buffer.read(s,filePath);
  s.sync;
  {PlayBuf(2, b, b.sampleRate / s.sampleRate)}.play;
});

r.play;
