resource "yandex_iam_service_account" "s3-robot" {
  folder_id = "${var.yandex_folder_id}"
  name      = "s3-robot"
}

resource "yandex_resourcemanager_folder_iam_member" "s3-robot-editor" {
  folder_id = "${var.yandex_folder_id}"
  role      = "admin"
  member    = "serviceAccount:${yandex_iam_service_account.s3-robot.id}"
}

resource "yandex_iam_service_account_static_access_key" "s3-robot-static-key" {
  service_account_id = "${yandex_iam_service_account.s3-robot.id}"
}
