{
  components: {
    "app": {
      "replicas": 1,
      "name": "web-app",
      "image": "foo4/clock",
      "ports": {
         "containerPort": 80
      },
      "service": {
         "port": 80
      }
    }
  }
}
