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
      ssh-keys = <<EOF
        ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDAQrqhEDvkOhgrnOksf0Q/8iHIafkADpI+dabnPVGrjfEilNcIW+WH0wPDO53nDJqPgKFE9eZ+5CpMEkMX96SoR2fmdmx80qVKGW6/5z9IMtHnzpVkAVtSDguA/JV/bMP4vwov/DsvDN+/FwJ16EwX0t3Q5VgELYw/o6I1u981CCj+VdmjE7xdf8dNI+jvHN+ho59C1TXhUBevluAjB3MhRe+j3pN6slzXgS2Dun99GvNjPVD14V6piA2V7Cb88haJ7SfzvOV7CrZfsjFZ0Q4eEKy9F3aNUiL7q0DqrFpoXCfpqM1I9D7Kt1b02UjOemAmYrmLCo/chA524gYvf1L6APuCC05u+bV7YCKiQTugVE17oFDzTu76PQ/qRtvxZGk+p4+DWSluwNQL+6oM1zEjH6anqV7QEFpoKTPU5nAKh6mV3xSNUkiJfc6qnZHKLdAOm4qozEPvx6nYw9pypaVUwK35+L4hTPt/yILerk5FT1fFuMQnOK9S4aOyisLHN2a3FHDenWOUsQszLSzrJxNNvhDqTo/fAXjqcItsUK9v0vDdhwiYydgSItoxsDEvyevySwLTkJugtwuEwVShCSPcWN8fq5FwxEV/4fhJDrOimbE+hV11k3/5JfuHoN92z5ucJgF8QLIfPkBxSjRXXEqVfhqg6JTqTWBx6l4mxE2OWQ==
      EOF  
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
