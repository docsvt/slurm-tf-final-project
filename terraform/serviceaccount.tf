# Creating a service account and assigning roles to it

resource "yandex_iam_service_account" "this" {
  name = "${local.prefix}-autoscale"
}

resource "yandex_resourcemanager_folder_iam_member" "this" {
  folder_id = data.yandex_resourcemanager_folder.this.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id = data.yandex_resourcemanager_folder.this.folder_id
  role = "editor"
  members = [ 
    "serviceAccount:${yandex_iam_service_account.this.id}", 
    ]
  depends_on = [
     yandex_iam_service_account.this,
   ]
}
