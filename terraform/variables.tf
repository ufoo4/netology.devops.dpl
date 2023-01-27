variable "YANDEX_CLOUD_ID" {
  default = "b1gffcps5oa5h9clc5o9"
}

variable "YANDEX_FOLDER_ID" {
  default = "b1g27gpcstr1l1bi3a22"
}

variable "TF_VAR_YC_CREDENTIAL" {
  type    = string
  default = ""
}

variable "TF_VAR_WORKSPACE_NAME" {
  type    = string
  default = ""
}

variable "DEFAUL_ZONE" {
  default = "local.networks.${var.TF_VAR_WORKSPACE_NAME}.0.zone_name"
}