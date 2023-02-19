local p = import '../params.libsonnet';
local params = p.components.app;
local env = {
  namespace: std.extVar('qbec.io/env'),
};

local imageTag = std.extVar('image_tag');

[
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app.kubernetes.io/component": params.name,
      "app.kubernetes.io/name": params.name
    },
    "name": params.name,
    "namespace": env.namespace
  },
  "spec": {
    "replicas": 1,
    "selector": {
      "matchLabels": {
        "app.kubernetes.io/component": params.name,
        "app.kubernetes.io/name": params.name
      }
    },
    "template": {
      "metadata": {
        "labels": {
         "app.kubernetes.io/component": params.name,
         "app.kubernetes.io/name": params.name
        }
      },
      "spec": {
        "containers": [
          {
            "env": null,
            "image": params.image + ':' + imageTag,
            "imagePullPolicy": "IfNotPresent",
            "name": params.name,
            "ports": [
              {
                "containerPort": params.ports.containerPort,
                "protocol": "TCP"
              }
            ]
          }
        ]
      }
    }
  }
},

{
  "apiVersion": "v1",
  "kind": "Service",
  "metadata": {
    "labels": {
      "app.kubernetes.io/component": params.name,
      "app.kubernetes.io/name": params.name
    },
    "name": params.name,
    "namespace": env.namespace
  },
  "spec": {
    "type": "ClusterIP",
    "ports": [
      {
        "name": "http",
          "protocol": "TCP",
          "port": params.service.port,
          "targetPort": params.ports.containerPort
      }
    ],
    "selector": {
        "app.kubernetes.io/component": params.name,
        "app.kubernetes.io/name": params.name
    }
  }
},
{
  "apiVersion": "networking.k8s.io/v1",
  "kind": "Ingress",
  "metadata": {
    "name": "web-app-ingress",
    "annotations": {
      "kubernetes.io/ingress.class": "nginx",
      "ingress.alb.yc.io/external-ipv4-address": "84.201.156.92"
    }
  },
  "spec": {
    "defaultBackend": {
      "service": {
        "name": "web-app",
        "port": {
          "number": 80
        }
      }
    },
    "rules": [
      {
        "host": "app.prod.foo4.ru",
        "http": {
          "paths": [
            {
              "path": "/",
              "pathType": "Prefix",
              "backend": {
                "service": {
                  "name": "web-app",
                  "port": {
                    "number": 80
                  }
                }
              }
            }
          ]
        }
      }
    ]
  }
}
]
