resource "yandex_kubernetes_cluster" "k8s_regional_cluster" {
  name       = local.cluster_name
  network_id = yandex_vpc_network.net.id
  master {
    version         = var.K8S_VERSION
    release_channel = "STABLE"
    public_ip       = true
    regional {
      region = "ru-central1"
      
      dynamic "location" {
        for_each = yandex_vpc_subnet.public
        content {
          zone = yandex_vpc_subnet.public["${location.key}"].zone
          subnet_id = yandex_vpc_subnet.public["${location.key}"].id
        }
      }
    }
    # security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
  }
  service_account_id      = yandex_iam_service_account.k8s_robot.id
  node_service_account_id = yandex_iam_service_account.k8s_robot.id
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms_key.id
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_binding.k8s_clusters_agent,
    yandex_resourcemanager_folder_iam_binding.vpc_public_admin,
    yandex_resourcemanager_folder_iam_binding.images_puller
  ]
}