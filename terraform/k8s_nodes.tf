# resource "yandex_kubernetes_node_group" "regional_node_group" {
#   cluster_id = yandex_kubernetes_cluster.k8s_regional_cluster.id
#   name       = "${var.TF_VAR_WORKSPACE_NAME}-regional-node-group"
#   version    = var.K8S_VERSION
#   instance_template {

#   }

# }