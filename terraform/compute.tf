resource "yandex_compute_instance" "this" {
  count                     = var.vm_count
  name                      = "${local.prefix}${var.vm_name}-${count.index}"
  platform_id               = "standard-v3"
  zone                      = var.yc_zones[count.index % length(var.yc_zones)]
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.this.id
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this[var.yc_zones[count.index % length(var.yc_zones)]].id
    nat       = true
  }

  metadata = {
    ssh-keys = var.public_ssh_key_path != "" ? "yc-user:${file(var.public_ssh_key_path)}" : "yc-user:${tls_private_key.this[0].public_key_openssh}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y"
    ]

    connection {
      host        = self.network_interface.0.nat_ip_address
      type        = "ssh"
      user        = "centos"
      private_key = var.private_ssh_key_path != "" ? file(var.private_ssh_key_path) : tls_private_key.this[0].private_key_openssh
      agent       = true
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u centos -i '${self.network_interface.0.nat_ip_address},' --private-key  ${local_file.yc_pem[0].filename} ansible/playbook.yml"

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}
