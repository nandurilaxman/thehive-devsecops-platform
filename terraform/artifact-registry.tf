resource "google_artifact_registry_repository" "thehive" {
  location      = var.region
  repository_id = "thehive-artifacts"
  description   = "TheHive container images"
  format        = "DOCKER"
}
