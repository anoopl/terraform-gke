resource "google_compute_network" "vpc" {
  name                    = "${var.vpc_network_name}"
  auto_create_subnetworks = "false"
}
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vpc_subnetwork_name}"
  ip_cidr_range = "${var.vpc_subnetwork_cidr}"
  network       = "${google_compute_network.vpc.name}"
  region        = "${var.region}"
  secondary_ip_range {
    range_name    = "${var.name}-k8s-pod"
    ip_cidr_range = "${var.pod_cidr}"
  }

  secondary_ip_range {
    range_name    = "${var.name}-k8s-svc"
    ip_cidr_range = "${var.svc_cidr}"
  }
}