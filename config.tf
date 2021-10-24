terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.89.0"
    }
  }
}

resource "google_service_account" "default" {
  account_id   = "889083590091-compute@developer.gserviceaccount.com"
  display_name = "Service Account"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "g-vm-${random_id.instance_id.hex}"
  machine_type = "f1-micro"
  zone         = "europe-north1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu/ubuntu-20.04"
    }
  }
      // Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install mc"

 network_interface {
   network = "default"
  }

    service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = 889083590091-compute@developer.gserviceaccount.com
    scopes = ["cloud-platform"]
  }
}