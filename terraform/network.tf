resource "yandex_vpc_network" "net" {
  name = "${terraform.workspace}-net"
}

resource "yandex_vpc_subnet" "public" {
  count          = length(local.networks)
  v4_cidr_blocks = local.networks[count.index].subnet
  zone           = local.networks[count.index].zone_name
  network_id     = yandex_vpc_network.net.id
  name           = "${terraform.workspace}-${local.networks[count.index].zone_name}"
}
