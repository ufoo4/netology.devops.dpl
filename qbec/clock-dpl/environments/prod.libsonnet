
// this file has the param overrides for the stage environment
local production = import './stage.libsonnet';

production {
  components +: {
    clock_dpl +: {
      replicas: 3,
      host: "app.prod.foo4.ru",
    }
  }
}
