variable "name" {
  type = "string"
  description = "Environment name"
}

variable "project" {
  type = "string"
  description = "Google Cloud project name"
}

variable "region" {
  type = "string"
  description = "Default Google Cloud region"
}
variable "vpc_network_name" {
  type = "string"

  description = "VPC Network to be used for the cluster"
}
variable "vpc_subnetwork_name" {
  type = "string"

  description = "VPC Subnet for the nodes"
}
variable "vpc_subnetwork_cidr" {
  type = "string"

  description = "VPC Subnet CIDR for the nodes"
}
variable "master_cidr" {
  type = "string"

  description = "CIDR for Kubernetes Masters"
}
variable "pod_cidr" {
  type = "string"

  description = "CIDR for Kubernetes Pods"
}
variable "svc_cidr" {
  type = "string"

  description = "CIDR for Kubernetes Services"
}
variable "nat_bgp_asn" {
  description = "Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit. The value will be fixed for this router resource. All VPN tunnels that link to this router will have the same local ASN."
  default     = "64514"
}
variable "node_machine_type" {
  description = "Node Instance/Machine type"
  default     = "n1-standard-1"
}
variable "image_type" {
  description = "Node OS Image name"
  default     = "ubuntu"
}
variable "disk_size" {
  description = "Node Disk size in GB"
  default     = "100"
}
variable "disk_type" {
  description = "Node Disk type"
  default     = "pd-standard"
}
variable "autoscaling_node_minimum" {
  description = "Minimum node in autoscaling"
  default     = "1"
}
variable "autoscaling_node_maximum" {
  description = "Maximum node in autoscaling"
  default     = "3"
}
variable "node_count" {
  description = "Number of nodes per zone"
  default     = "1"
}
variable "zones" { 
  type    = list(string)
  default = ["us-cental1-a"]
}
variable "bastion_image" {
  description = "Image type for Bastion/Jump Host"
  default     = "debian-cloud/debian-9"
}
variable "bastion_machine_type" {
  description = "Machine type for Bastion/Jump Host"
  default     = "g1-small"
}
variable "spinnaker_machine_type" {
  description = "Machine type for Spinnaker"
  default     = "n1-standard-4"
}
variable "spinnaker_image" {
  description = "Image type for spinnaker"
  default     = "ubuntu-os-cloud/ubuntu-1404-lts"
}