// on machine running the server
(
s.options.protocol = \tcp; // set to use tcp
s.options.bindAddress = "0.0.0.0"; // allow connections from any address
s.options.inDevice_("ASIO : Focusrite USB ASIO");
s.options.maxLogins = 32; // set to correct number of clients
s.scope;
s.boot;
)
// s.makeWindow;
s.freqscope;
s.plotTree
s.freeAll
Group.freeAll
s.freeAll
ServerOptions.inDevices
s.freqscope