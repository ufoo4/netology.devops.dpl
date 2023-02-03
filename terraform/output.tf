output "external_v4_endpoint" {
  description = "An IPv4 external network address that is assigned to the master."

  value = yandex_kubernetes_cluster.cluster.master[0].external_v4_endpoint
}

output "internal_v4_endpoint" {
  description = "An IPv4 internal network address that is assigned to the master."

  value = yandex_kubernetes_cluster.cluster.master[0].internal_v4_endpoint
}

output "cluster_ca_certificate" {
  description = <<-EOF
  PEM-encoded public certificate that is the root of trust for
  the Kubernetes cluster.
  EOF

  value = yandex_kubernetes_cluster.cluster.master[0].cluster_ca_certificate
}

output "cluster_id" {
  description = "ID of a new Kubernetes cluster."

  value = yandex_kubernetes_cluster.cluster.id
}
