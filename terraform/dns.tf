# variable "dns_zone_id" {
#   default = "none"
# }
# variable "dns_record_ttl" {
#   default = 60
# }
# data "yandex_dns_zone" "zone" {
#   dns_zone_id = var.dns_zone_id
# }

# resource "yandex_dns_recordset" "ingress" {
#   count   = var.dns_zone_id == "none" ? 0 : 1
#   zone_id = data.yandex_dns_zone.zone.id
#   name    = "*.k8s"
#   type    = "A"
#   ttl     = var.dns_record_ttl
#   data    = [data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].ip]
  
#   depends_on = [
#     data.kubernetes_service.ingress_nginx
#   ]
# }

resource "yandex_dns_zone" "dns_name" {
  name   = replace(local.dns_name, ".", "-")
  zone   = join("", [local.dns_name, "."])
  public = true
  private_networks = [yandex_vpc_network.net.id]
}


resource "yandex_dns_recordset" "dns_record_argocd" {
  zone_id = yandex_dns_zone.dns_name.id
  name    = join("", [local.argocd_dns_name, "."])
  type    = "A"
  ttl     = 200
  data    = [data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].ip]
}

# resource "yandex_dns_recordset" "dns_record_monitoring" {
#   zone_id = yandex_dns_zone.dns_name.id
#   name    = join("", [local.mon_dns_name, "."])
#   type    = "A"
#   ttl     = 200
#   data    = [yandex_vpc_address.external_ingress.external_ipv4_address[0].address]
# }

# resource "yandex_dns_recordset" "dns_record_prometheus" {
#   zone_id = yandex_dns_zone.dns_name.id
#   name    = join("", [local.prom_dns_name, "."])
#   type    = "A"
#   ttl     = 200
#   data    = [yandex_vpc_address.external_ingress.external_ipv4_address[0].address]
# }

# resource "yandex_dns_recordset" "dns-record-grafana" {
#   zone_id = yandex_dns_zone.dns_zone_yc.id
#   name    = "grafana"
#   type    = "CNAME"
#   ttl     = 200
#   data    = [local.url]
# }

# resource "yandex_dns_recordset" "dns-record-app" {
#   zone_id = yandex_dns_zone.dns_zone_yc.id
#   name    = "clock-dpl"
#   type    = "CNAME"
#   ttl     = 200
#   data    = [local.url]
# }

# resource "yandex_dns_recordset" "dns-record-testapp-stage" {
#   zone_id = yandex_dns_zone.dns_zone_yc.id
#   name    = "clock-dpl-stage"
#   type    = "CNAME"
#   ttl     = 200
#   data    = [local.url]
# }
