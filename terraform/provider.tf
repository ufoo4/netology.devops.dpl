terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  cloud {
    organization = "netology-dpl"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["netology-dpl"]
    }
  }
}

provider "yandex" {
  cloud_id                 = var.YANDEX_CLOUD_ID
  folder_id                = var.TF_VAR_YANDEX_FOLDER_ID
  service_account_key_file = var.TF_VAR_YC_CREDENTIAL
  zone                     = local.default_zone
}

provider "helm" {
  kubernetes {
    host                   = yandex_kubernetes_cluster.k8s_regional_cluster.master[0].external_v4_endpoint
    cluster_ca_certificate = yandex_kubernetes_cluster.k8s_regional_cluster.master[0].cluster_ca_certificate
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["k8s", "create-token"]
      command     = "yc"
    }
  }
}
