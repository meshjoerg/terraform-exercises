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

resource "google_bigquery_dataset" "analytics_lab" {
  dataset_id                  = "analytics_lab"
  location                    = "EU"
  default_table_expiration_ms = 604800000
}