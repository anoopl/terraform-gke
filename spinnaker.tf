resource "google_compute_instance" "spinnaker" {
  name         = "${var.name}-spinnaker"
  project      = "${var.project}"
  zone         = "${element(var.zones, 0)}"
  machine_type = "${var.spinnaker_machine_type}"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "${var.spinnaker_image}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.subnet.self_link}"

    access_config {
      # Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  tags = ["spinnaker"]
}

# Allow SSH for spinnaker Host
resource "google_compute_firewall" "spinnaker" {
  name    = "${var.name}-spinnaker"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "8084", "9000"]
  }

  target_tags = ["spinnaker"]
}