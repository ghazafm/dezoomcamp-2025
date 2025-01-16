variable "credentials" {
  description = "Credentials"
  default = "./keys/gcp-creds2.json"
}


variable "project" {
  description = "Project"
  type        = string
  default     = "terraform-demo-433104"
}

variable "location" {
  description = "Location"
  type        = string
  default     = "asia-southeast2"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "asia-southeast2"
}

variable "bq_dataset_name" {
  description = "Dataset Name"
  type        = string
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "Google Storage Bucket Name"
  type        = string
  default     = "terraform-demo-433104-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Google Storage Class"
  type        = string
  default     = "STANDARD"
}