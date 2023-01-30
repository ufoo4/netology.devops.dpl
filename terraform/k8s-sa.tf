resource "yandex_iam_service_account" "k8s_robot" {
  name        = "${var.TF_VAR_WORKSPACE_NAME}-k8s-robot"
  description = "K8S regional service account for ${var.TF_VAR_WORKSPACE_NAME}"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s_clusters_agent" {
  folder_id = var.TF_VAR_YANDEX_FOLDER_ID
  role      = "k8s.clusters.agent"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc_public_admin" {
  folder_id = var.TF_VAR_YANDEX_FOLDER_ID
  role      = "vpc.publicAdmin"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}
resource "yandex_resourcemanager_folder_iam_binding" "images_puller" {
  folder_id = var.TF_VAR_YANDEX_FOLDER_ID
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

#### Нужен ли он? Над подумать, а пока потестирую.
resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}",
  ]
}
