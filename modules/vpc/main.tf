resource "google_compute_network" "vpc" {
  name                    = "${var.project}-vpc-${var.environment}"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "public" {
  count         = length(var.subnetPublicCidrs)
  name          = "${var.project}-subnet-public-${count.index}-${var.environment}"
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.subnetPublicCidrs[count.index]
}

resource "google_compute_subnetwork" "private" {
  count                    = length(var.subnetPrivateCidrs)
  name                     = "${var.project}-subnet-private-${count.index}-${var.environment}"
  region                   = var.region
  network                  = google_compute_network.vpc.id
  ip_cidr_range            = var.subnetPrivateCidrs[count.index]
  private_ip_google_access = true
}

resource "google_vpc_access_connector" "connector" {
  name          = "${var.project}-connector-${var.environment}"
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow_internet" {
  name    = "${var.project}-internet-${var.environment}"
  network = google_compute_network.vpc.id
  depends_on = [
    google_compute_network.vpc
  ]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_private_public" {
  name    = "${var.project}-private-public-${var.environment}"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = concat(
    google_compute_subnetwork.private[*].ip_cidr_range,
    google_compute_subnetwork.public[*].ip_cidr_range
  )

  target_tags = ["${var.project}-private-public-${var.environment}"]
}