var main = {
  var port = 5005;
  var ip = "172.30.246.232"; // wsl address
  ("sent to:" + ip ++ ":" ++ port).postln;
  NetAddr(ip, port).sendMsg("/status", 1, 3)
}.();
