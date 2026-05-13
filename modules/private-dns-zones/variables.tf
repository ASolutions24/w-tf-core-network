variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "zones" {
  description = "Map of Private DNS zones"
  type = map(object({
    name = string
  }))
}

variable "vnet_id" {
  description = "Hub VNet ID to link DNS zones"
  type        = string
}