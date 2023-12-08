resource "google_service_account" "service_account" {
  account_id   = "${var.project}-sa-${var.environment}"
  display_name = "${var.project} ${var.displayName} ${var.environment}"
}

resource "google_project_iam_custom_role" "storage_role" {
  role_id     = "customStorageRole"
  title       = "Custom Storage Role"
  description = "Terraform generated storage role."
  permissions = [ 
    "storage.objects.list", 
    "storage.objects.get",
    "storage.objects.create",
    "storage.objects.delete"
  ]
}

resource "google_project_iam_member" "storage_role_attachment" {
  project = var.project
  role    = google_project_iam_custom_role.storage_role.id
  member  = "serviceAccount:${google_service_account.service_account.email}"
}