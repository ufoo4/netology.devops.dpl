#######################################
## Переменные, хранящиеся в TF Cloud ##
#######################################

variable "TF_VAR_YC_CREDENTIAL" {
  type    = string
  default = ""
}

variable "TF_VAR_WORKSPACE_NAME" {
  type    = string
  default = ""
}

variable "TF_VAR_YANDEX_FOLDER_ID" {
  default = ""  
}

###########################
## Локальные переменные  ##
###########################

variable "YANDEX_CLOUD_ID" {
  default = "b1gffcps5oa5h9clc5o9"
}

# variable "YANDEX_FOLDER_ID" {
#   default = "b1g27gpcstr1l1bi3a22"
# }

variable "K8S_VERSION" {
  default = "1.23"
}
