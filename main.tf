module "cloud-storage" {
  source = "./modules/cloud_storage"
  region = var.region
  project = var.project
  environment = var.environment
}