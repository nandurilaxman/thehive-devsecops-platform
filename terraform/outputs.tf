output "cluster_name" {
  value = google_container_cluster.thehive.name
}

output "artifact_registry" {
  value = google_artifact_registry_repository.thehive.name
}
