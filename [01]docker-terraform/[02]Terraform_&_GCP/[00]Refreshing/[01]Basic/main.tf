terraform {
    required_providers {
        google = {
        source  = "hashicorp/google"
        version = "5.42.0"
        }
    }
}

provider "google" {
    credentials = "./keys/my_cred.json"
    project = "terraform-demo-433104"
    region  = "us-central1"
}

resource "google_storage_bucket" "auto-expire" {
    name          = "terraform-demo-433104"
    location      = "US"
    force_destroy = true

    lifecycle_rule {
        condition {
        age = 3
        }
        action {
        type = "Delete"
        }
    }

    lifecycle_rule {
        condition {
        age = 1
        }
        action {
        type = "AbortIncompleteMultipartUpload"
        }
    }
}
