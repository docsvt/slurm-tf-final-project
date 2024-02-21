variable "yc_image_id" {
  type        = string
  description = "Yandex cloud image id"
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
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

variable "image_family" {
    type = string
    description = "Cloud image family"
    default = "centos-7"
}
