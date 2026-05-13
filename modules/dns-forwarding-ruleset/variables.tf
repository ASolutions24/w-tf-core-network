variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "outbound_endpoint_id" {
  type = string
}

variable "rules" {
  type = list(object({
    name        = string
    domain_name = string
    target_dns_servers = list(object({
      ip   = string
      port = number
    }))
  }))
}

variable "vnet_id" {
  type = string
}