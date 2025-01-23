Specs.setFile(Path.fromRepoRoot("artifacts/scd_runtime.json"));
Runtime.setConfig(Json.load(Path.fromRepoRoot("sc.config.json")));

Client
  .setup(Runtime.getHost, Runtime.getPort)
  .doWhenBooted(Load.scd("workspace"));
