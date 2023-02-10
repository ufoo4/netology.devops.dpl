resource "yandex_dns_zone" "dns_zone_yc" {
  name             = "dns-zone-yc"
  zone             = "${local.dns_zone}."
  public           = true
  private_networks = [yandex_vpc_network.net.id]
}

resource "yandex_dns_recordset" "dns_record_k8s_regional_cluster" {
  zone_id    = yandex_dns_zone.dns_zone_yc.id
  name       = local.cluster_name
  type       = "A"
  ttl        = 200
  data       = [yandex_kubernetes_cluster.k8s_regional_cluster.master[0].external_v4_endpoint]
  depends_on = [yandex_kubernetes_cluster.k8s_regional_cluster]
}

resource "yandex_dns_recordset" "dns-record-grafana" {
  zone_id = yandex_dns_zone.dns_zone_yc.id
  name    = "grafana"
  type    = "CNAME"
  ttl     = 200
  data    = [local.url]
}

resource "yandex_dns_recordset" "dns-record-app" {
  zone_id = yandex_dns_zone.dns_zone_yc.id
  name    = "clock-dpl"
  type    = "CNAME"
  ttl     = 200
  data    = [local.url]
}

resource "yandex_dns_recordset" "dns-record-testapp-stage" {
  zone_id = yandex_dns_zone.dns_zone_yc.id
  name    = "clock-dpl-stage"
  type    = "CNAME"
  ttl     = 200
  data    = [local.url]
}
