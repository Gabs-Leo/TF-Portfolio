module "cloud-storage" {
  source = "./modules/cloud_storage"
  region = var.region
  project = var.project
  environment = var.environment
}

module "database" {
  source = "./modules/database"
  region = var.region
  project = var.project
  environment = var.environment
  databaseVersion = var.databaseVersion
  databaseTier = var.databaseTier
}