resource "yandex_kubernetes_cluster" "k8s-regional-cluster" {
  name       = local.cluster_name
  network_id = yandex_vpc_network.net.id
  master {
    version = var.K8S_VERSION
    public_ip = true
    regional {
      region = "ru-central1"
      
      dynamic "location" {
        for_each = yandex_vpc_subnet.public
        content {
          zone = yandex_vpc_subnet.public["${location.key}"].zone
          subnet_id = yandex_vpc_subnet.public["${location.key}"].id
        }
      }



      # location {
      #   count          = local.networks
      #   zone      = local.networks[count.index].zone_name
      #   # subnet_id = yandex_vpc_subnet.public[count.index]
      # }
    #   location {
    #     zone      = yandex_vpc_subnet.public-subnet-b.zone
    #     subnet_id = yandex_vpc_subnet.public-subnet-b.id
    #   }
    #   location {
    #     zone      = yandex_vpc_subnet.public-subnet-c.zone
    #     subnet_id = yandex_vpc_subnet.public-subnet-c.id
    #   }
    }
    # security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
  }
  service_account_id      = yandex_iam_service_account.k8s-robot.id
  node_service_account_id = yandex_iam_service_account.k8s-robot.id
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_binding.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_binding.vpc-public-admin,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
}
