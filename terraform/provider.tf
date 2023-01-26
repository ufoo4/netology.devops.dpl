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
  service_account_key_file = "${var.TF_VAR_YC_CREDENTIAL}"
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "netology-dpl"

    workspaces {
      prefix = "my-app-"
    }
  }
}

# terraform {
#   cloud {
#     organization = "netology-dpl"

#     workspaces {
#       name = "stage"
#     }
#   }
# }