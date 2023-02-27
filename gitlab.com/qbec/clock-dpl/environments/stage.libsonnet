{
  components: {
    "clock_dpl": {
      "replicas": 1,
      "name": "clock-dpl",
      "image": "cr.yandex/crprhackbsfen591qk9s/clock-dpl",
      "namespace": "app",
      "ports": {
         "containerPort": 80
      },
      "service": {
         "port": 80
      },
      "host": "app.stage.foo4.ru"
    }
  }
}
