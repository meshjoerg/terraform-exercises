variable "project_id" {
  description = "The Google Cloud project ID used for the lab."
  type        = string
}

variable "region" {
  description = "The default Google Cloud region for provider operations."
  type        = string
  default     = "us-west1"
}

variable "bucket_name" {
  description = "The globally unique name of the storage bucket."
  type        = string
}

variable "bucket_location" {
  description = "The location where the storage bucket will be created."
  type        = string
  default     = "us-west1"
}

variable "enable_versioning" {
  description = "Controls whether object versioning is enabled for the bucket."
  type        = bool
  default     = true
}

variable "labels" {
  description = "Labels applied to the storage bucket."
  type        = map(string)

  default = {
    environment = "student-lab"
    managed_by  = "terraform"
  }
}