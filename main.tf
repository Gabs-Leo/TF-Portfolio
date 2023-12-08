/*
module "database" {
  source = "./modules/database"
  region = var.region
  project = var.project
  environment = var.environment
  databaseVersion = var.databaseVersion
  databaseTier = var.databaseTier
}
module "vpc" {
  source = "./modules/vpc"
  region = var.region
  project = var.project
  environment = var.environment
  subnetPrivateCidrs = var.subnetPrivateCidrs
  subnetPublicCidrs = var.subnetPublicCidrs
}
*/

module "service_account" {
  source = "./modules/service_account"
  environment = var.environment
  project = var.project
  displayName = "storage-access"
}
module "cloud-storage" {
  source = "./modules/cloud_storage"
  region = var.region
  project = var.project
  environment = var.environment
}
module "cloud_run" {
  source = "./modules/cloud_run"
  project = var.project
  region = var.region
  environment = var.environment
  registryUrl = var.registryUrl
}

module "secrets_manager" {
  source = "./modules/secrets_manager"
  project = var.project
  environment = var.environment
  region = var.region
}