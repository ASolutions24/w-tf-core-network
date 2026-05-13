location = "australiaeast"

# HUB
hub_vnet_name            = "vnet-hub"
hub_vnet_cidr            = "10.100.0.0/16"
hub_rg_name              = "rg-network-hub"
#hub_firewall_subnet_cidr = "10.100.1.0/24"
hub_subnets = {
  AzureFirewallSubnet = {
    address_prefixes = ["10.100.1.0/24"]
  }

  sn-management = {
    address_prefixes = ["10.100.2.0/24"]
  }

  sn-shared = {
    address_prefixes = ["10.100.3.0/24"]
  }

  dns-inbound = {
    address_prefixes = ["10.100.4.0/28"]
  }

  dns-outbound = {
    address_prefixes = ["10.100.4.16/28"]
  }
}
hub_subscription_id      = "39aca73e-1d25-4edf-84d5-ebe0397a816b"

# FIREWALL
firewall_name            = "azfw-hub"
firewall_pip_name        = "azfw-hub-pip"

# Privare DNS Zones
private_dns_zones = {
  blob = {
    name = "privatelink.blob.core.windows.net"
  }
  file = {
    name = "privatelink.file.core.windows.net"
  }
  sql = {
    name = "privatelink.database.windows.net"
  }
}

# Private DNS Resolver
dns_forwarding_rules = [
  {
    name        = "onprem"
    domain_name = "corp.local."
    target_dns_servers = [
      {
        ip   = "10.1.0.4"
        port = 53
      }
    ]
  }
]