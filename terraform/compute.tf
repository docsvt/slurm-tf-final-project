resource "yandex_compute_instance_group" "this" {
  name               = "${local.prefix}-autoscale-ig"
  folder_id          = data.yandex_resourcemanager_folder.this.folder_id
  service_account_id = yandex_iam_service_account.this.id
  instance_template {

    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.yc_image_id
        size     = 30
      }
    }

    network_interface {
      network_id = yandex_vpc_network.this.id
      subnet_ids = [for subnet in yandex_vpc_subnet.this : subnet.id]
      nat        = true
    }

    # metadata = {
    #   user-data = templatefile("config.tpl", {
    #     VM_USER = var.vm_user
    #     SSH_KEY = var.ssh_key
    #   })
    #   docker-container-declaration = file("declaration.yaml")
    # }
  }

  scale_policy {
    auto_scale {
      initial_size           = var.yc_min_zone_size * length(var.yc_zones)
      measurement_duration   = 60
      cpu_utilization_target = 40
      min_zone_size          = var.yc_min_zone_size
      max_size               = var.yc_max_group_size
      warmup_duration        = 30
    }
  }

  allocation_policy {
    zones = var.yc_zones
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  application_load_balancer {
    target_group_name        = "${local.prefix}-apb-tg"
    target_group_description = "A target group for application load balancer"
    target_group_labels      = var.labels
  }
  
  depends_on = [
    yandex_iam_service_account.this,
    yandex_resourcemanager_folder_iam_binding.this,
  ]

}
