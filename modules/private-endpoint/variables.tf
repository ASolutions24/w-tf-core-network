variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "private_connection_resource_id" {
  description = "Target resource ID (e.g. storage account, key vault)"
  type        = string
}

variable "subresource_names" {
  description = "Subresource names (e.g. blob, vault, sqlServer)"
  type        = list(string)
}

variable "manual_connection" {
  description = "Set true if manual approval is required"
  type        = bool
  default     = false
}

# Optional DNS integration
variable "private_dns_zone_ids" {
  description = "List of Private DNS Zone IDs (optional)"
  type        = list(string)
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}