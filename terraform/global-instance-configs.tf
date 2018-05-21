resource "google_compute_instance" "mrm-vault-server-instance" {
  name                    = "${var.platform-name}-vault-server"
  description             = "For help with secret management"
  machine_type            = "n1-standard-1"
  zone                    = "${var.gcloud-zone}"
  metadata_startup_script = "${lookup(var.startup_scripts, "vault-server")}"

  boot_disk {
    initialize_params {
      image = "${var.platform-name}-vault-image"
    }
  }

  tags = ["vault-server", "no-ip"]

  network_interface {
    subnetwork = "${google_compute_subnetwork.private-db-va.self_link}"
    address    = "${google_compute_address.ip-static-vault.address}"
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "nat-gateway-instance" {
  name                    = "${var.platform-name}-nat-gateway-server"
  description             = "nat instance"
  machine_type            = "n1-standard-1"
  zone                    = "${var.gcloud-zone}"
  metadata_startup_script = "${lookup(var.startup_scripts, "nat-server")}"

  boot_disk {
    initialize_params {
      image = "${var.platform-name}-nat-gateway-image"
    }
  }

  tags = ["nat-server", "public", "nat", "http-server", "https-server"]

  network_interface {
    subnetwork = "${google_compute_subnetwork.public-subnet.self_link}"

    access_config {}
  }

  can_ip_forward = "true"

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "mrm-postgresql-instance" {
  name         = "${var.platform-name}-postgresql-server"
  description  = "System Database"
  machine_type = "n1-standard-1"
  zone         = "${var.gcloud-zone}"

  boot_disk {
    initialize_params {
      image = "${var.platform-name}-postgres-image"
    }
  }

  tags = ["postgresql-server", "no-ip", "postgres-server"]

  network_interface {
    subnetwork = "${google_compute_subnetwork.private-db-va.self_link}"
    address    = "${google_compute_address.ip-static-postgresql.address}"
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "mrm-barman-instance" {
  name         = "${var.platform-name}-barman-server"
  description  = "Backup Server for Postgres Instance"
  machine_type = "n1-standard-1"
  zone         = "${var.gcloud-zone}"

  boot_disk {
    initialize_params {
      image = "${var.platform-name}-barman-image"
    }
  }

  tags       = ["barman-server", "no-ip"]
  depends_on = ["google_compute_instance.mrm-postgresql-instance"]

  network_interface {
    subnetwork = "${google_compute_subnetwork.private-db-va.self_link}"
    address    = "${google_compute_address.ip-static-barman.address}"
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}
