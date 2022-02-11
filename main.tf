provider "google" {
  project     = "instagram-analytics-341015"
  region      = "europe-west1"
  zone        = "europe-west1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_storage_bucket" "cs_instagram-01" {
  name          = "cs_instagram-01"
  location      = "EU"
}
resource "google_folder" "Brutes" {
  display_name  = "Brutes"
  bucket        = "${google_storage_bucket.cs_instagram-01.name}"
}

# Folder nested under another folder.
resource "google_folder" "Raffines" {
  display_name = "Raffines"
  bucket       = "${google_storage_bucket.cs_instagram-01.name}"
}