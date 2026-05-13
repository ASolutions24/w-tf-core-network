dns_records = {
  blob = {
    zone_name           = "privatelink.blob.core.windows.net"
    resource_group_name = "rg-network-hub"

    records = [
      {
        name   = "storage1"
        type   = "A"
        ttl    = 300
        values = ["10.100.2.4"]
      }
    ]
  }
}
hub_subscription_id      = "39aca73e-1d25-4edf-84d5-ebe0397a816b"