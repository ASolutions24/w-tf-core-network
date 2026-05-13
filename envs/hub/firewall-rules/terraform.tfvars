/*
location = "australiaeast"

# HUB
hub_vnet_name            = "vnet-hub"
hub_vnet_cidr            = "10.100.0.0/16"
hub_rg_name              = "rg-network-hub"
hub_firewall_subnet_cidr = "10.100.1.0/24"
hub_subscription_id      = "39aca73e-1d25-4edf-84d5-ebe0397a816b"

# FIREWALL
firewall_name            = "azfw-hub"
firewall_pip_name        = "azfw-hub-pip"
*/
hub_subscription_id      = "39aca73e-1d25-4edf-84d5-ebe0397a816b"

firewall_name            = "azfw-hub"
firewall_rg_name         = "rg-network-hub"

network_rule_collections = [
  {
    name     = "allow-internet"
    priority = 100
    action   = "Allow"

    rules = [
      {
        name                  = "allow-http-https"
        source_addresses      = ["10.0.0.0/8"]
        destination_addresses = ["0.0.0.0/0"]
        destination_ports     = ["80", "443"]
        protocols             = ["TCP"]
      }
    ]
  },
  {
    name     = "allow-dns"
    priority = 110
    action   = "Allow"

    rules = [
      {
        name                  = "dns"
        source_addresses      = ["10.0.0.0/8"]
        destination_addresses = ["168.63.129.16"]
        destination_ports     = ["53"]
        protocols             = ["UDP", "TCP"]
      }
    ]
  }
]