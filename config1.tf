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
  name         = "vm-${random_id.instance_id.hex}"
  machine_type = "f1-micro"
  zone         = "europe-north1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-lts"
    }
  }
  metadata_startup_script = "sudo apt update -y; sudo apt install mc -y"

  network_interface {
    network = "default"
  }
}