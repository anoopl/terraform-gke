#Create GKE Cluster
resource "google_container_cluster" "kubernetes" {
  name               = "${var.name}"
  location           = "${var.region}"
  node_locations     = ["us-central1-a", "us-central1-b", "us-central1-c"]
  #node_locations    = ["us-central1-a"]
  network            = "${google_compute_network.vpc.name}"
  subnetwork         = "${google_compute_subnetwork.subnet.self_link}"
  #service_account    = default
  ip_allocation_policy {
    cluster_secondary_range_name = "${var.name}-k8s-pod"
    services_secondary_range_name = "${var.name}-k8s-svc"
    #cluster_ipv4_cidr_block = "10.8.0.0/16"
    #services_ipv4_cidr_block = "10.9.0.0/16"
  }
  private_cluster_config {
    enable_private_nodes = "true"
    master_ipv4_cidr_block = "${var.master_cidr}"
    enable_private_endpoint = "true"
  }
  master_authorized_networks_config  {
    cidr_blocks {
     cidr_block = "0.0.0.0/0"
     display_name = "external"

    }
  }
  addons_config {
    network_policy_config {
      disabled = "false"
    }
  }
  network_policy {
    enabled = "true"
    provider = "CALICO"
  }
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count = "${var.autoscaling_node_minimum}"
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.name}-node-pool"
  location   = "${var.region}"
  cluster    = "${google_container_cluster.kubernetes.name}"
  node_count = "${var.autoscaling_node_minimum}"
  autoscaling {
      min_node_count = "${var.autoscaling_node_minimum}"
      max_node_count =  "${var.autoscaling_node_maximum}"
    }
  management {
      auto_repair = "true"
      auto_upgrade = "true"
    }
  node_config {
    #preemptible  = true
    machine_type = "${var.node_machine_type}"
    image_type   = "${var.image_type}"
    disk_size_gb = "${var.disk_size}"
    disk_type    = "${var.disk_type}"
    local_ssd_count = 1
    

    metadata = {
      disable-legacy-endpoints = "true"
    }
    
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}
