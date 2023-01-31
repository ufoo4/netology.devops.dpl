locals {
  default_zone = "local.networks.${var.TF_VAR_WORKSPACE_NAME}.0.zone_name"
  cluster_name = "${var.TF_VAR_WORKSPACE_NAME}-k8s-regional-cluster"
  # control_url  = "${local.cluster_name}.${local.dns_zone}"
  # ingress_url  = "${local.cluster_name}-ingress.${local.dns_zone}"
  # dns_zone     = "yc.complife.ru"

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


}
