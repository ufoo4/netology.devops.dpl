terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  cloud {
    organization = "ntlg-dpl"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["yc-dpl"]
    }
  }
}

provider "yandex" {
  cloud_id  = var.YANDEX_CLOUD_ID
  folder_id = var.YANDEX_FOLDER_ID
  zone      = local.default_zone
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

provider "kubernetes" {
  host                   = yandex_kubernetes_cluster.k8s_regional_cluster.master[0].external_v4_endpoint
  cluster_ca_certificate = yandex_kubernetes_cluster.k8s_regional_cluster.master[0].cluster_ca_certificate
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["k8s", "create-token"]
    command     = "yc"
  }
}
