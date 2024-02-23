
# resource "yandex_lb_target_group" "this" {
#   name = "${local.prefix}lb-tg"
#   dynamic "target" {
#     for_each = yandex_compute_instance.this
#     content {
#         subnet_id = target.value.network_interface.0.subnet_id
#         address   = target.value.network_interface.0.ip_address   
#     }
#   }
# }

# resource "yandex_lb_network_load_balancer" "this" {
#   name                = "${local.prefix}load-balancer"
#   type                = "external"
#   deletion_protection = false
#   listener {
#     name = "${local.prefix}listener"
#     port = 80
#   }
#   attached_target_group {
#     target_group_id = yandex_lb_target_group.this.id
#     healthcheck {
#       name = var.nlb_healthcheck.name
#       http_options {
#         port = var.nlb_healthcheck.port
#         path = var.nlb_healthcheck.path
#       }
#     }
#   }
# }
