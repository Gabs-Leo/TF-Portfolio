resource "google_storage_bucket" "image_storage" {
  name          = "${var.project}-bucket-${var.environment}"
  location      = var.region
  force_destroy = true
}