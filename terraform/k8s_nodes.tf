resource "yandex_kubernetes_node_group" "regional_node_group" {
  cluster_id  = yandex_kubernetes_cluster.k8s_regional_cluster.id
  name        = "${var.TF_VAR_WORKSPACE_NAME}-regional-node-group"
  version     = var.K8S_VERSION

  instance_template {

    platform_id = local.k8s_cluster_resources[var.TF_VAR_WORKSPACE_NAME].workers.platform_id

    resources {
      memory        = local.k8s_cluster_resources[var.TF_VAR_WORKSPACE_NAME].workers.memory
      cores         = local.k8s_cluster_resources[var.TF_VAR_WORKSPACE_NAME].workers.cpu
      core_fraction = local.k8s_cluster_resources[var.TF_VAR_WORKSPACE_NAME].workers.core_fraction
    }

    boot_disk {
      type = local.k8s_cluster_resources[var.TF_VAR_WORKSPACE_NAME].workers.disk_type
      size = local.k8s_cluster_resources[var.TF_VAR_WORKSPACE_NAME].workers.disk_size
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
      size = local.k8s_cluster_resources[var.TF_VAR_WORKSPACE_NAME].workers.scale
    }
  }

  depends_on = [
    yandex_kubernetes_cluster.k8s_regional_cluster
  ]
}
