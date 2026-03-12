resource "google_storage_bucket" "example" {
  name     = var.bucket_name
  location = var.bucket_location

  versioning {
    enabled = var.enable_versioning
  }

  labels = var.labels
}