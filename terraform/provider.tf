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
