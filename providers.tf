terraform {
  backend "gcs" {
    bucket = "gabsleo-us-central1-terraform"
    prefix = "prod/terraform.tfstate"
  }
}

provider "google" {
  project = var.project
  region  = var.region
}