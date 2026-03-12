terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "<project-id>"
  region  = "us-west1"
}

resource "google_storage_bucket" "example" {
  name     = "<my-bucket-unique-id>"
  location = "us-west1"

  versioning {
    enabled = true
  }

  labels = {
    environment = "student-lab"
    managed_by  = "terraform"
  }
}

output "bucket_name" {
  value = google_storage_bucket.example.name
}

resource "google_bigquery_dataset" "analytics_lab" {
  dataset_id                  = "analytics_lab"
  location                    = "EU"
  default_table_expiration_ms = 604800000
}