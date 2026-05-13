variable "name" {
  type = string
}

variable "target_resource_id" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "logs" {
  type    = list(string)
  default = []
}

variable "metrics" {
  type    = list(string)
  default = ["AllMetrics"]
}