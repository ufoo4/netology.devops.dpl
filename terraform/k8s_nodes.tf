resource "yandex_kubernetes_node_group" "regional_node_group" {
  cluster_id = yandex_kubernetes_cluster.k8s_regional_cluster.id
  name       = "${var.TF_VAR_WORKSPACE_NAME}-regional-node-group"
  version    = var.K8S_VERSION

  instance_template {

    platform_id = "standard-v3"

    resources {
      memory = 2
      cores  = 1
      core_fraction=20
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    network_interface {
      nat = true
      subnet_ids = [ for subnet in yandex_vpc_subnet.public : subnet.id ]
    }

    metadata = {
      ssh-keys = "ubuntu:${file("./id_rsa.pub")}"

    }
  }

  allocation_policy {

    dynamic "location" {
      for_each = yandex_vpc_subnet.public
      content {
        zone   = yandex_vpc_subnet.public["${location.key}"].zone
      }
    }
  } 

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  depends_on = [
    yandex_kubernetes_cluster.k8s_regional_cluster
  ]
}
