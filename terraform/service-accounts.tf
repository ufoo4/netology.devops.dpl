### Registry-sa
resource "yandex_iam_service_account" "registry_agent" {
  name = "${terraform.workspace}-registry-agent"
}

resource "yandex_container_registry_iam_binding" "registry_agent_pusher" {
  registry_id = yandex_container_registry.dpl_registry.id
  role        = "container-registry.images.pusher"
  members     = ["serviceAccount:${yandex_iam_service_account.registry_agent.id}"]
  depends_on  = [
    yandex_iam_service_account.registry_agent,
    yandex_container_registry.dpl_registry
  ]
}

resource "yandex_container_registry_iam_binding" "registry_agent_puller" {
  registry_id = yandex_container_registry.dpl_registry.id
  role        = "container-registry.images.puller"
  members     = ["serviceAccount:${yandex_iam_service_account.registry_agent.id}"]
  depends_on  = [
    yandex_iam_service_account.registry_agent,
    yandex_container_registry.dpl_registry
  ]
}

resource "yandex_iam_service_account_key" "registry_agent_key" {
  service_account_id = yandex_iam_service_account.registry_agent.id
  description        = "SA key for registry agent"
  depends_on = [
    yandex_iam_service_account.registry_agent
  ]
}

### K8S-sa
resource "yandex_iam_service_account" "k8s_robot" {
  name        = "${terraform.workspace}-k8s-robot"
  description = "K8S regional service account for ${terraform.workspace}"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s_clusters_agent" {
  folder_id = var.YANDEX_FOLDER_ID
  role      = "k8s.clusters.agent"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc_public_admin" {
  folder_id = var.YANDEX_FOLDER_ID
  role      = "vpc.publicAdmin"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc_private_admin" {
  folder_id = var.YANDEX_FOLDER_ID
  role      = "load-balancer.admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images_puller" {
  folder_id = var.YANDEX_FOLDER_ID
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}"
  ]
}

resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.kms_key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s_robot.id}",
  ]
}
