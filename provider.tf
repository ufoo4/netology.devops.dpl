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
  service_account_key_file = "${YC_SERVICE_ACCOUNT_KEY_FILE}"
}

terraform {
  cloud {
    organization = "netology-dpl"

    workspaces {
      name = "stage"
    }
  }
}
