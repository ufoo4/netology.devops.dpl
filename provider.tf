terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
  token     = "$YC_TOKEN"
}

terraform {
  cloud {
    organization = "netology-dpl"

    workspaces {
      name = "stage"
    }
  }
}