locals {
  default_zone    = "local.networks.0.zone_name"
  cluster_name    = "${terraform.workspace}-k8s-regional-cluster"
  dns_name        = "foo4.ru"
  argocd_dns_name = "argocd.foo4.ru"

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
        scale              = 1 #Заменить значение после тестирования
        cpu                = 2
        core_fraction      = 100 # Заменить значение на 5
        memory             = 2 # Заменить значение на 1
        disk_size          = 64
        disk_type          = "network-hdd"
        platform_id        = "standard-v1"
        serial-port-enable = 1
      }
    }
    prod = {
      workers = {
        scale              = 1 #Заменить значение после тестирования
        cpu                = 2
        core_fraction      = 100 # Заменить значение на 20
        memory             = 2
        disk_size          = 64
        disk_type          = "network-ssd"
        platform_id        = "standard-v1"
        serial-port-enable = 1
      }
    }
  }
}
