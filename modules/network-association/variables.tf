variable "subnet_ids" {
  description = "Map of subnet IDs"
  type        = map(string)
}

variable "nsg_ids" {
  description = "Map of NSG IDs"
  type        = map(string)
}

variable "route_table_ids" {
  description = "Map of Route Table IDs"
  type        = map(string)
}