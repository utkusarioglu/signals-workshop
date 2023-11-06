// on machine running the server
(
s.options.protocol = \tcp; // set to use tcp
s.options.bindAddress = "0.0.0.0"; // allow connections from any address
s.options.maxLogins = 32; // set to correct number of clients

s.makeWindow;
s.scope;
s.freqscope;

s.boot;
)
