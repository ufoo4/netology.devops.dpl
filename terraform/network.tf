resource "yandex_vpc_network" "net" {
  name = "${var.TFC_WORKSPACE_NAME}-net"
}

resource "yandex_vpc_subnet" "public" {
  count          = length(local.networks)
  v4_cidr_blocks = local.networks[count.index].subnet
  zone           = local.networks[count.index].zone_name
  network_id     = yandex_vpc_network.net.id
  name           = "${var.TFC_WORKSPACE_NAME}-${local.networks[count.index].zone_name}"
}

# resource "yandex_vpc_network" "net-prod" {
#   name = "net-prod"
# }

# resource "yandex_vpc_subnet" "public-prod" {
#   count          = length(local.networks)
#   v4_cidr_blocks = local.networks[count.index].subnet
#   zone           = local.networks[count.index].zone_name
#   network_id     = yandex_vpc_network.net-prod.id
#   name           = "subnet-${local.networks[count.index].zone_name}"
# }
