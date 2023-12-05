terraform {
  backend "gcs" {
    bucket = "gabsleo-us-central1-terraform"
    prefix = "prod/terraform.tfstate"
    version = "5.8.0"
  }
}

provider "google" {
  project = var.project
  region  = var.region
}