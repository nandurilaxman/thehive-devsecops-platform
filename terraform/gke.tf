resource "google_container_cluster" "thehive" {
  name     = "thehive-gke"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.thehive_vpc.name
  subnetwork = google_compute_subnetwork.gke_subnet.name
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-pool"
  location   = var.region
  cluster    = google_container_cluster.thehive.name

  node_count = 3

  node_config {
    machine_type = "e2-standard-4"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
