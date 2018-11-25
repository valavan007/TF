// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("../keys/sa.json")}"
  project     = "bnc-pso-poc"
  region      = "us-central1"
}

// Create a new instance
resource "google_compute_instance" "test" {
  count        = 1 // Adjust as desired
  name         = "test${count.index + 1}" // yields "test1", "test2", etc. It's also the machine's name and hostname
  machine_type = "f1-micro" // smallest (CPU &amp; RAM) available instance
  zone         = "us-central1-b" // yields "europe-west1-d" as setup previously. Places your VM in Europe

 
boot_disk {
initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default" 
    access_config {
          network_tier = "STANDARD"
         }
    } 
  }
