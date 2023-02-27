local p = import '../params.libsonnet';
local params = p.components.clock_dpl;
local env = {
  namespace: std.extVar('qbec.io/env'),
};

local imageTag = std.extVar('image_tag');

[
{
  "apiVersion": "v1",
  "kind": "Namespace",
  "metadata": {
    "name": params.namespace
  },
},

{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app.kubernetes.io/component": params.name,
      "app.kubernetes.io/name": params.name
    },
    "name": params.name,
    "namespace": params.namespace
  },
  "spec": {
    "replicas": params.replicas,
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
    "namespace": params.namespace
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
    "annotations": {
      "kubernetes.io/ingress.class": "nginx",
      "cert-manager.io/cluster-issuer": "letsencrypt-prod"
    },
    "name": params.name,
    "namespace": params.namespace
  },
  "spec": {
    "tls": [
      {
        "hosts": [
          params.host
        ],
        "secretName": "app-certificate"
      },
    ],
    "defaultBackend": {
      "service": {
        "name": params.name,
        "port": {
          "number": params.ports.containerPort
        }
      }
    },
    "rules": [
      {
        "host": params.host,
        "http": {
          "paths": [
            {
              "path": "/",
              "pathType": "Prefix",
              "backend": {
                "service": {
                  "name": params.name,
                  "port": {
                    "number": params.service.port
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
