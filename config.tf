terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.89.0"
    }
  }
}

provider "google" {
 credentials = file("CREDENTIALS_FILE.json")
 project     = "new1-330022"
 region      = "europe-north1"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 1
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
  count = 1
  name         = "vm-${random_id.instance_id.hex}"
  machine_type = "e2-micro"         #f1-micro g1-small e2-micro e2-small e2-medium
  zone         = "europe-north1-a"
  metadata_startup_script = "sudo apt update -y; sudo apt install mc -y"

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "default"

  access_config {
    // Include this section to give the VM an external ip address
    }
  }
}