#export GOOGLE_CLOUD_KEYFILE_JSON=microservices-test-23d2b9503f79.json
provider "google" {
  credentials = "${file("microservices-test-245710-9efe72863fce.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}
