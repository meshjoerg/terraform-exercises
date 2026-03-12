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
  # force_destroy = true

  versioning {
    enabled = true
  }

  labels = {
    environment = "student-lab"
    managed_by  = "terraform"
  }
}

resource "google_storage_bucket_iam_binding" "example_binding" {
  bucket = google_storage_bucket.example.name
  role   = "roles/storage.objectViewer"  # view-only access
  # role   = "roles/storage.objectUser"  # writing/uploading possible

  members = [
    "user:<email of your co-student>"  # ⚠️ Replace with actual email
  ]
}

output "bucket_name" {
  value = google_storage_bucket.example.name
}
