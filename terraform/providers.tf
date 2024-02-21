terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  cloud_id  = "b1g4aekrc5dc24a3n74v"
  folder_id = "b1g79lp1n0pnt14u706n"
  zone = "ru-central1-a"
}
