variable "yc_resource_folder" {
  type = string
  description = "Resource manager folder for instance group"
  default = "default"
}

variable "yc_image_id" {
  type        = string
  description = "Yandex cloud image id"
}

variable "vm_image_name" {
  type        = string
  description = "Name used image"
  default  = "nginx"
}

variable "vm_image_tag" {
  type        = string
  description = "Tag for group image"
}

variable "cidr_blocks" {
  type        = list(list(string))
  description = "List of IPv4 cidr blocks for subnet"
}

variable "labels" {
  type        = map(string)
  description = "Labels to add to resources"
}

variable "yc_zones" {
  type        = list(string)
  description = "Yandex cloud zone mapping"
}

variable "public_ssh_key_path" {
  type        = string
  description = "ssh public key path"
  default     = ""
}

variable "private_ssh_key_path" {
  type        = string
  description = "ssh private key path"
  default     = ""
}

variable "nlb_healthcheck" {
  type = object(
    {
      name = string
      port = number
      path = string
    }
  )

  description = "Load balancer healthcheck"
}

variable "vm_count" {
    type = number
    description = "VM total"
    default = 3 
}
