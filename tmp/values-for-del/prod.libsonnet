
// this file has the param overrides for the stage environment
local production = import './stage.libsonnet';

production {
  components +: {
    app +: {
      replicas: 2,
    }
  }
}
