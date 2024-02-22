resource "yandex_compute_instance_group" "this" {
  name                = "${local.prefix}-autoscale-ig"
  folder_id           = yandex_resourcemanager_folder.this.folder_id
  service_account_id  = yandex_iam_service_account.this.id
  instance_template {

    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.this.id
        size     = 30
      }
    }

    network_interface {
      network_id = yandex_vpc_network.this.id
      subnet_ids = yandex_vpc_subnet.this.*.id
      security_group_ids = [ yandex_vpc_security_group.sg-1.id ]
      nat                = true
    }

    metadata = {
      user-data = templatefile("config.tpl", {
        VM_USER = var.vm_user
        SSH_KEY = var.ssh_key
      })
      docker-container-declaration = file("declaration.yaml")
    }
  }

  scale_policy {
    auto_scale {
      initial_size           = 2
      measurement_duration   = 60
      cpu_utilization_target = 40
      min_zone_size          = 1
      max_size               = 6
      warmup_duration        = 120
    }
  }

  allocation_policy {
    zones = [
      "ru-central1-a",
      "ru-central1-b"
    ]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name        = "auto-group-tg"
    target_group_description = "load balancer target group"
  }
}
