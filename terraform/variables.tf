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

# variable "TFC_WORKSPACE_NAME" {
#   type    = string
#   default = ""
# }

variable "network_cidr" {
  type    = list(string)
  default = {
    stage = "10.0.0.0/16"
    prod  = "10.1.0.0/16"
  }
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = {
    stage = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
    prod  = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
  }
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = {
    stage = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
    prod  = ["10.1.3.0/24", "10.1.4.0/24", "10.1.5.0/24"]
  }
}
