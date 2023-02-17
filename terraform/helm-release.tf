resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.4.2"
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

resource "helm_release" "cert-manager" {
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.11.0"
  namespace        = "cert-manager"
  name             = "cert-manager"
  create_namespace = true
  values           = [file("./values/cert-manager.yml")]

  depends_on = [
    yandex_kubernetes_node_group.regional_node_group
  ]
}

# resource "helm_release" "cert-manager-issuers" {
#   repository       = "https://charts.helm.sh/incubator"
#   chart            = "raw"
#   namespace        = "cert-manager"
#   name             = "cert-manager-issuers"
#   wait             = false
#   create_namespace = true
#   values           = [file("./values/cert-manager-issuers.yml")]

#   depends_on = [
#     helm_release.cert-manager
#   ]
# }

resource "helm_release" "argo_cd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.20.4"
  namespace        = "argocd"
  create_namespace = true
  # values           = [file("./values/argocd.yml")]

  depends_on = [
    helm_release.cert-manager,
    helm_release.ingress_nginx
  ]
}

