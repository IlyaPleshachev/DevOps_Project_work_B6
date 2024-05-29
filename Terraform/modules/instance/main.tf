terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.117.0"
    }
  }
}

data "yandex_compute_image" "edu_image" {
  family = var.edu_instance_family_image  
}

resource "yandex_compute_instance" "vm" {
  name = "edu-${var.edu_instance_name}"
  hostname = "edu-${var.edu_instance_name}"
  zone = var.edu_instance_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.edu_image.id
      size = 20
    }
  }

  network_interface {
    subnet_id = var.edu_vpc_subnet_id
    nat       = true
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }
}
