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

  # set {
  #   name  = "controller.publishService.enabled"
  #   value = "true"
  # }
  # set {
  #   name  = "controller.metrics.enabled"
  #   value = "true"
  # }
  # set {
  #   name  = "controller.stats.enabled"
  #   value = "true"
  # }

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
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.11.0"
  namespace        = "cert-manager"
  name             = "cert-manager"
  create_namespace = true
  cleanup_on_fail  = true
  # values           = [file("./values/cert-manager.yml")]
  
  set {
    name  = "installCRDs"
    value = true
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}

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

resource "helm_release" "gitlab_agent" {
  name             = "gitlab-agent"
  repository       = "https://charts.gitlab.io"
  chart            = "gitlab-agent"
  create_namespace = true
  namespace        = "gitlab-agent"
  # version          = "v15.9.0"
  cleanup_on_fail  = true

  set {
    name  = "config.kasAddress"
    value = var.KAS_ADDRESS
  }
  set {
    name  = "config.token"
    value = var.AGENT_TOKEN
  }

  # depends_on = [
  #   helm_release.cert_manager_issuers
  # ]
}

