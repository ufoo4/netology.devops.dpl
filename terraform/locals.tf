locals {
  default_zone    = "local.networks.0.zone_name"
  cluster_name    = "${terraform.workspace}-k8s-regional-cluster"
  dns_name        = "foo4.ru"
  mon_dns_name    = "mon.${terraform.workspace}.foo4.ru"
  app_dns_name    = "app.${terraform.workspace}.foo4.ru"

  ingress_values = {
    fullnameOverride = "ingress-nginx"
  }

  networks = [
    {
      zone_name = "ru-central1-a"
      subnet    = ["10.0.10.0/24"]
    },
    {
      zone_name = "ru-central1-b"
      subnet    = ["10.0.11.0/24"]
    },
    {
      zone_name = "ru-central1-c"
      subnet    = ["10.0.12.0/24"]
    }
  ]

  k8s_cluster_resources = {
    stage = {
      workers = {
        scale              = 1
        cpu                = 2
        core_fraction      = 20
        memory             = 4
        disk_size          = 64
        disk_type          = "network-hdd"
        platform_id        = "standard-v1"
        serial-port-enable = 1
      }
    }
    prod = {
      workers = {
        scale              = 3
        cpu                = 2
        core_fraction      = 20
        memory             = 4
        disk_size          = 64
        disk_type          = "network-ssd"
        platform_id        = "standard-v1"
        serial-port-enable = 1
      }
    }
  }
}
