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

variable "SSH_KEYS" {
  type = map
  default = {
    "ubuntu" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDAQrqhEDvkOhgrnOksf0Q/8iHIafkADpI+dabnPVGrjfEilNcIW+WH0wPDO53nDJqPgKFE9eZ+5CpMEkMX96SoR2fmdmx80qVKGW6/5z9IMtHnzpVkAVtSDguA/JV/bMP4vwov/DsvDN+/FwJ16EwX0t3Q5VgELYw/o6I1u981CCj+VdmjE7xdf8dNI+jvHN+ho59C1TXhUBevluAjB3MhRe+j3pN6slzXgS2Dun99GvNjPVD14V6piA2V7Cb88haJ7SfzvOV7CrZfsjFZ0Q4eEKy9F3aNUiL7q0DqrFpoXCfpqM1I9D7Kt1b02UjOemAmYrmLCo/chA524gYvf1L6APuCC05u+bV7YCKiQTugVE17oFDzTu76PQ/qRtvxZGk+p4+DWSluwNQL+6oM1zEjH6anqV7QEFpoKTPU5nAKh6mV3xSNUkiJfc6qnZHKLdAOm4qozEPvx6nYw9pypaVUwK35+L4hTPt/yILerk5FT1fFuMQnOK9S4aOyisLHN2a3FHDenWOUsQszLSzrJxNNvhDqTo/fAXjqcItsUK9v0vDdhwiYydgSItoxsDEvyevySwLTkJugtwuEwVShCSPcWN8fq5FwxEV/4fhJDrOimbE+hV11k3/5JfuHoN92z5ucJgF8QLIfPkBxSjRXXEqVfhqg6JTqTWBx6l4mxE2OWQ=="
  }
}

variable "K8S_VERSION" {
  default = "1.23"
}

variable "CLUSTER_IPV4_RANGE" {
  default = "10.112.0.0/16"
}

variable "SERVICE_IPV4_RANGE" {
  default = "10.96.0.0/16"
}

variable "K8S_CLUSTER_RESOURCES" {
  stage = {
    workers = {
      count         = 3
      cpu           = 2
      core_fraction = 20
      memory        = 1
      disk          = 64
      disk_type     = "network-hdd"
      preemptible   = false
      platform_id   = "standard-v3"
    }
  }
  prod = {
    workers = {
      count         = 6
      cpu           = 2
      core_fraction = 100
      memory        = 4
      disk          = 64
      disk_type     = "network-ssd"
      preemptible   = false
      platform_id   = "standard-v1"
    }
  }
}

