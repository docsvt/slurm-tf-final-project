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
  image_description   = "Slurm nginx image"
  image_family        = "centos-nginx-server"
  image_name          = "nginx-${var.image_tag}"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  subnet_id           = "${var.image_subnet}"
  use_ipv4_nat        = true
  zone                = "${var.image_zone}"
}

build {
  sources = ["source.yandex.this"]

  provisioner "ansible" {
    playbook_file = "./ansible/playbook.yml"
    ansible_env_vars = [ "ANSIBLE_ROLES_PATH=../ansible", "ANSIBLE_HOST_KEY_CHECKING=False" ]    
  }

}
