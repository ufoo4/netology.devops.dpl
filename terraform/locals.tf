locals {
  default_zone = "local.networks.${var.TF_VAR_WORKSPACE_NAME}.0.zone_name"
  cluster_name = "${var.TF_VAR_WORKSPACE_NAME}-k8s-regional-cluster"
  dns_zone     = "yc.dpl.ru"
  # control_url  = "${local.cluster_name}.${local.dns_zone}"
  url  = "${local.cluster_name}.${local.dns_zone}"


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
        scale         = 1
        cpu           = 2
        core_fraction = 5
        memory        = 1
        disk_size     = 64
        disk_type     = "network-hdd"
        platform_id   = "standard-v1"
      }
    }
    prod = {
      workers = {
        scale         = 3
        cpu           = 2
        core_fraction = 20
        memory        = 2
        disk_size     = 64
        disk_type     = "network-ssd"
        platform_id   = "standard-v1"
      }
    }
  }
}
