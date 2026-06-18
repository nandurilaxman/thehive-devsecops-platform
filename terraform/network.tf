resource "google_compute_network" "thehive_vpc" {
  name                    = "thehive-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.10.0.0/20"
  region        = var.region
  network       = google_compute_network.thehive_vpc.id
}
