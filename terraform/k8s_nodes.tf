resource "yandex_kubernetes_node_group" "regional_nodes" {
  cluster_id = yandex_kubernetes_cluster.k8s_regional_cluster.id
  name       = "k8s-regional-nodes-a"
  version    = "${var.k8s_version}"

}