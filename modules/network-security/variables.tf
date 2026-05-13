variable "subnets" {
  type = map(object({
    subnet_name     = string
    location        = string
    resource_group  = string
  }))
}