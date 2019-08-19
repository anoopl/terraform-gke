# Create an external NAT IP
#resource "google_compute_address" "nat" {
#  count   = "${var.private_cluster == 1 && var.cloud_nat == 1 ? 1: 0 }"
#  name    = "${var.name}-nat"
#  project = "${var.project}"
#  region  = "${var.region}"
#}

# Create a NAT router so the nodes can reach DockerHub, etc
resource "google_compute_router" "router" {
  name        = "${var.name}"
  network     = "${google_compute_network.vpc.self_link}"
  project     = "${var.project}"
  region      = "${var.region}"
  description = "Nat router for${var.name} cluster"

  bgp {
    asn = "${var.nat_bgp_asn}"
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.name}"
  project                            = "${var.project}"
  router                             = "${google_compute_router.router.name}"
  region                             = "${var.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}