# data "yandex_compute_image" "this" {
#   name = "${var.image_name}-${var.image_tag}"
# }

data "yandex_resourcemanager_folder" "this" {
    name = var.yc_resource_folder
}
