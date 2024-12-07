// p = PathName([
//   File.getcwd, 
//   "assets",
//   "cat.txt"
// ].reduce('+/+'));
// File.mkdir(p.pathOnly);
// File.use(p.fullPath, "a", { | f |
//   f.write("hi");
// });

File.use([
  File.getcwd,
  "src",
  "supercollider",
  "temp",
  "if.scd"
].reduce('+/+'), 
"w", 
{ | f |
  f.write("");
})
