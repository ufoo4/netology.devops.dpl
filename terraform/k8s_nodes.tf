resource "yandex_kubernetes_node_group" "regional_node_group" {
  cluster_id = yandex_kubernetes_cluster.k8s_regional_cluster.id
  name       = "${var.TF_VAR_WORKSPACE_NAME}-regional-node-group"
  version    = var.K8S_VERSION

  instance_template {

    platform_id = "var.K8S_CLUSTER_RESOURCES.${var.TF_VAR_WORKSPACE_NAME}.workers.platform_id"

    resources {
      memory = 2
      cores  = 2
      core_fraction=20
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    container_runtime {
     type = "containerd"
    }

    network_interface {
      # nat = true
      subnet_ids = [ for subnet in yandex_vpc_subnet.public : subnet.id ]
    }

    metadata = {
      ssh-keys = join("\n", [for user, key in var.SSH_KEYS : "${user}:${key}"])
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
