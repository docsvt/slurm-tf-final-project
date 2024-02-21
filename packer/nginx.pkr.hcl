variable "image_folder" {
  type =  string
}

variable "image_tag" {
  type = string
}

variable "image_subnet" {
  type = string
}


variable "image_zone" {
  type = string
  default = "ru-central1-a"
}

source "yandex" "this" {
  disk_type           = "network-ssd"
  folder_id           = "${var.image_folder}"
  image_description   = "my custom debian with nginx"
  image_family        = "debian-web-server"
  image_name          = "nginx-${var.image_tag}"
  source_image_family = "debian-11"
  ssh_username        = "debian"
  subnet_id           = "${var.image_subnet}"
  use_ipv4_nat        = true
  zone                = "${var.image_zone}"
}

build {
  sources = ["source.yandex.this"]

  provisioner "shell" {
    inline = ["echo 'updating APT'", "sudo apt-get update -y", "sudo apt-get install -y nginx", "sudo su -", "sudo systemctl enable nginx.service", "curl localhost"]
  }

}
