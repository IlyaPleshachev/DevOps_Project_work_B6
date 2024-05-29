terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.117.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "tf-edu-state-bucket-pw6"
    region     = "ru-central1-a"
    key        = "edu/terraform-lemp.tfstate"
    access_key = "ACCESS"
    secret_key = "DENIED"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone_a
}

resource "yandex_vpc_network" "edu_network" {
  name = "edu-network"
}

resource "yandex_vpc_subnet" "edu_subnet" {
  name           = "edu-subnet1"
  zone           = var.zone_a
  network_id     = yandex_vpc_network.edu_network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

module "edu_ya_instance_vm1" {
  source                    = "./modules/instance"
  edu_instance_family_image = "ubuntu-2004-lts"
  edu_instance_zone         = var.zone_a
  edu_instance_name         = "vm1-ubuntu-2004"
  edu_vpc_subnet_id         = yandex_vpc_subnet.edu_subnet.id
}

module "edu_ya_instance_vm2" {
  source                    = "./modules/instance"
  edu_instance_family_image = "ubuntu-2004-lts"
  edu_instance_zone         = var.zone_a
  edu_instance_name         = "vm2-ubuntu-2004"
  edu_vpc_subnet_id         = yandex_vpc_subnet.edu_subnet.id
}

module "edu_ya_instance_vm3" {
  source                    = "./modules/instance"
  edu_instance_family_image = "centos-stream-8"
  edu_instance_name         = "vm3-centos-8"
  edu_instance_zone         = var.zone_a
  edu_vpc_subnet_id         = yandex_vpc_subnet.edu_subnet.id
}