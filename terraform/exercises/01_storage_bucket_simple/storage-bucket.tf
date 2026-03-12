terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "<project-id>"  # ⚠️ Replace with your actual project ID
  region  = "us-west1"
}

resource "google_storage_bucket" "mybucket" {
  name     = "<my-bucket-unique-id>" # ⚠️ Ensure globally unique
  location = "us-west1"
}

output "bucket_name" {
  value = google_storage_bucket.mybucket.name
}
