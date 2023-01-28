terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "netology-dpl"

    workspaces {
      prefix = "workspace-"
    }
  }
}
