variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}