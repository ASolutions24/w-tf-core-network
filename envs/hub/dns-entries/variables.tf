variable "dns_records" {
  type = map(object({
    zone_name           = string
    resource_group_name = string

    records = list(object({
      name   = string
      type   = string # A, CNAME
      ttl    = number
      values = list(string)
    }))
  }))
}

variable "hub_subscription_id" {}