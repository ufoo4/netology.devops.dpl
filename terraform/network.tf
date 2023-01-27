resource "yandex_vpc_network" "net" {
  name = "net"
}

resource "yandex_vpc_subnet" "public" {
  count          = length(local.networks)
  v4_cidr_blocks = "local.networks.${var.TFC_WORKSPACE_NAME}.[count.index].subnet"
  zone           = "local.networks.${var.TFC_WORKSPACE_NAME}.[count.index].zone_name"
  network_id     = yandex_vpc_network.net.id
  name           = "subnet-${local.networks[count.index].zone_name}"
}
