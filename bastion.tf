resource "google_compute_instance" "bastion" {
  name         = "${var.name}-bastion"
  project      = "${var.project}"
  zone         = "${element(var.zones, 0)}"
  machine_type = "${var.bastion_machine_type}"
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "${var.bastion_image}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.subnet.self_link}"

    access_config {
      # Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }

  tags = ["bastion"]
}

# Allow SSH for Bastion Host
resource "google_compute_firewall" "bastion" {
  name    = "${var.name}-bastion"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["bastion"]
}