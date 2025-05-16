var env = Environment.make {
  ~dur = 0.25;
  ~midinote = 88;
  ~amp = 0.5;
};

env.use {
  Event.default.copy.putAll(env).play;
};
