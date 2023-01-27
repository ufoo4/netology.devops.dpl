resource "yandex_vpc_network" "net-stage" {
  name = "net-stage"
}

resource "yandex_vpc_subnet" "public-stage" {
  count          = length(local.networks)
  v4_cidr_blocks = local.networks[count.index].subnet
  zone           = local.networks[count.index].zone_name
  network_id     = yandex_vpc_network.net-stage.id
  name           = "subnet-${local.networks[count.index].zone_name}"
}

resource "yandex_vpc_network" "net-prod" {
  name = "net-prod"
}

resource "yandex_vpc_subnet" "public-prod" {
  count          = length(local.networks)
  v4_cidr_blocks = local.networks[count.index].subnet
  zone           = local.networks[count.index].zone_name
  network_id     = yandex_vpc_network.net-prod.id
  name           = "subnet-${local.networks[count.index].zone_name}"
}
