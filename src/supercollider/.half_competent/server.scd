// on machine running the server
(
// Server.killAll;
// Platform.userExtensionDir = File.getcwd ++ "\\src\\supercollider\\extensions";
s.options.protocol = \tcp; // set to use tcp
s.options.bindAddress = "0.0.0.0"; // allow connections from any address
s.options.inDevice_("ASIO : Focusrite USB ASIO");
// s.options.inDevice_("Windows WASAPI : Analogue 1 + 2");
// s.options.inDevice_("Windows WASAPI : Loopback L + R");
s.options.maxLogins = 32; // set to correct number of clients
s.boot;
)
// s.makeWindow;
// s.scope;
// s.freqscope;
// s.plotTree
// s.freeAll
// Group.freeAll
// s.freeAll
// ServerOptions.inDevices
// ServerOptions.outDevices
// s.freqscope
