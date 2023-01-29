resource "yandex_iam_service_account" "k8s-robot" {
  count       = "${TF_VAR_WORKSPACE_NAME}"
  name        = "k8s-robot"
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-clusters-agent" {
  count       = "${TF_VAR_WORKSPACE_NAME}"
  folder_id = var.YANDEX_FOLDER_ID
  role      = "k8s.clusters.agent"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-robot.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-public-admin" {
  count       = "${TF_VAR_WORKSPACE_NAME}"
  folder_id = var.YANDEX_FOLDER_ID
  role      = "vpc.publicAdmin"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-robot.id}"
  ]
}
resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  count       = "${TF_VAR_WORKSPACE_NAME}"
  folder_id = var.YANDEX_FOLDER_ID
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-robot.id}"
  ]
}

#### Нужен ли он? Над подумать, а пока потестирую.
resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  count       = "${TF_VAR_WORKSPACE_NAME}"
  symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-robot.id}",
  ]
}
