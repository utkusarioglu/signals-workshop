{
  var content = Dictionary.new;
  var repoRoot = PathName(PathName(File.getcwd).parentPath).parentPath;
  var filePath = PathName(repoRoot +/+ "f.json");
  ~bus = Bus.control(s, 4);
  ~bus.scope;
  content.put(\index, ~bus.index);
  content.put(\numChannels, ~bus.numChannels);
  content.put(\rate, ~bus.rate);
  content.put(\langPort, NetAddr.langPort);
  File(filePath.fullPath, "w").write(content.asJSON).close;
}.();
