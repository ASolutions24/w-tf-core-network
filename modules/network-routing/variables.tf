variable "subnets" {
  description = "Flattened subnet map from network-core module"
  type = map(object({
    subnet_name    = string
    location       = string
    resource_group = string
  }))
}