resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.2.1"
  wait       = true
  depends_on = [
    yandex_kubernetes_node_group.regional_node_group
  ]
  set {
    name  = "controller.service.loadBalancerIP"
    value = yandex_vpc_address.addr.external_ipv4_address[0].address
  }
}
