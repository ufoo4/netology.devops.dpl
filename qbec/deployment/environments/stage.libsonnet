{
  components: {
    "clock_dpl": {
      "replicas": 1,
      "name": "clock-dpl",
      "image": "foo4/clock-dpl",
      "namespace": "app",
      "ports": {
         "containerPort": 80
      },
      "service": {
         "port": 80
      },
    }
  }
}
