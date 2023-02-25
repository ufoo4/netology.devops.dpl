resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.5.2"
  wait             = true
  namespace        = "ingress-nginx"
  create_namespace = true
  cleanup_on_fail  = true
  values           = [yamlencode(local.ingress_values)]

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }
  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }
  set {
    name  = "controller.stats.enabled"
    value = "true"
  }

  depends_on = [
    yandex_kubernetes_node_group.regional_node_group
  ]
}

data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = format("%s-controller", local.ingress_values.fullnameOverride)
    namespace = helm_release.ingress_nginx.namespace
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  values = [
    <<-EOF
    installCRDs: true
    prometheus:
      enabled: false
      servicemonitor:
        enabled: false
    clusterResourceNamespace: cert-manager
    extraArgs:
      - --cluster-resource-namespace=cert-manager
  EOF
  ]

  depends_on = [
    data.kubernetes_service.ingress_nginx
  ]
}

resource "helm_release" "cert_manager_issuer" {
  name       = "cert-manager-issuer"
  repository = "https://charts.helm.sh/incubator"
  chart      = "raw"
  values = [
    <<-EOF
    resources:
      - apiVersion: cert-manager.io/v1
        kind: ClusterIssuer
        metadata:
          name: letsencrypt-prod
          namespace: cert-manager
        spec:
          acme:
            email: u.foo@outlook.com
            server: https://acme-v02.api.letsencrypt.org/directory
            privateKeySecretRef:
              name: letsencrypt-prod
            solvers:
            - http01:
                ingress:
                  ingressTemplate:
                    metadata:
                      annotations:
                        kubernetes.io/ingress.class: nginx
    EOF
  ]
  
  depends_on = [
    helm_release.cert_manager
  ]
}


# resource "helm_release" "cert_manager" {
#   repository       = "https://charts.jetstack.io"
#   chart            = "cert-manager"
#   version          = "1.11.0"
#   namespace        = "cert-manager"
#   name             = "cert-manager"
#   create_namespace = true
#   cleanup_on_fail  = true
#   # values           = [file("./values/cert-manager.yml")]
  
#   set {
#     name  = "installCRDs"
#     value = true
#   }

#   depends_on = [
#     data.kubernetes_service.ingress_nginx
#   ]
# }

# resource "helm_release" "cert_manager_issuers" {
#   repository       = "https://charts.helm.sh/incubator"
#   chart            = "raw"
#   namespace        = "cert-manager"
#   name             = "cert-manager-issuers"
#   wait             = false
#   create_namespace = true
#   cleanup_on_fail  = true
#   values           = [file("./values/cert-manager-issuers.yml")]

#   depends_on = [
#     helm_release.cert_manager
#   ]
# }