location = "australiaeast"

# HUB
hub_vnet_name       = "vnet-hub"       #Not required for peering if reading from hub network state file
hub_rg_name         = "rg-network-hub" #Not required for peering if reading from hub network state file
hub_subscription_id = "39aca73e-1d25-4edf-84d5-ebe0397a816b"

# SPOKE
spoke_vnet_name       = "vnet-tf-prod"
spoke_vnet_cidr       = "10.0.0.0/24"
spoke_rg_name         = "rg-network-prod"
spoke_subnet_name     = "sn-prod-vm"
spoke_subnet_cidr     = "10.0.0.0/27"
spoke_subscription_id = "2f054702-74ef-49dc-8055-920692478b36"

# ROUTING
route_table_name   = "rt-prod-vm"
default_route_name = "default-to-firewall"