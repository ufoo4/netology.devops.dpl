resource "yandex_vpc_network" "net" {
  name = "net"
  labels = "${var.TFC_WORKSPACE_NAME}"
}

resource "yandex_vpc_subnet" "public" {
  count          = length(local.networks)
  v4_cidr_blocks = local.networks[count.index].subnet
  zone           = local.networks[count.index].zone_name
  network_id     = yandex_vpc_network.net.id
  name           = "subnet-${local.networks[count.index].zone_name}"
}
