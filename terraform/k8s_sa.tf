resource "yandex_iam_service_account" "k8s-robot" {
  name        = "k8s-robot"
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-clusters-agent" {
  folder_id = var.YANDEX_FOLDER_ID
  role      = "k8s.clusters.agent"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-robot.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-public-admin" {
  folder_id = var.YANDEX_FOLDER_ID
  role      = "vpc.publicAdmin"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-robot.id}"
  ]
}
resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  folder_id = var.YANDEX_FOLDER_ID
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-robot.id}"
  ]
}

#### Нужен ли он? Над подумать, а пока потестирую.
resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-robot.id}",
  ]
}
