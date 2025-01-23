{
  var p;
  p = PathName("cat/dog.txt");

  File.mkdir(p.pathOnly);

  File.use(p.fullPath, "a", _.write("woofie"));
}.();
