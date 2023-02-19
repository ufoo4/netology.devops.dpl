
resource "yandex_dns_zone" "dns_name" {
  name             = replace(local.dns_name, ".", "-")
  zone             = join("", [local.dns_name, "."])
  public           = true
  private_networks = [yandex_vpc_network.net.id]

  depends_on = [
    helm_release.ingress_nginx
  ]
}

resource "yandex_dns_recordset" "dns_record_mon" {
  zone_id = yandex_dns_zone.dns_name.id
  name    = join("", [local.mon_dns_name, "."])
  type    = "A"
  ttl     = 200
  data    = [data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].ip]
  
  depends_on = [
    helm_release.ingress_nginx
  ]
}

resource "yandex_dns_recordset" "dns_record_app" {
  zone_id = yandex_dns_zone.dns_name.id
  name    = join("", [local.app_dns_name, "."])
  type    = "A"
  ttl     = 200
  data    = [data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].ip]
  
  depends_on = [
    helm_release.ingress_nginx
  ]
}
