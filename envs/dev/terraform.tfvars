location = "australiaeast"

# HUB
hub_vnet_name       = "vnet-hub"       #Not required for peering if reading from hub network state file
hub_rg_name         = "rg-network-hub" #Not required for peering if reading from hub network state file
hub_subscription_id = "39aca73e-1d25-4edf-84d5-ebe0397a816b"

# SPOKE
spoke_vnet_name = "vnet-tf-dev"
spoke_vnet_cidr = "10.0.1.0/24"
spoke_rg_name   = "rg-network-dev"
#spoke_subnet_name        = "sn-dev-vm"
#spoke_subnet_cidr        = "10.0.1.0/27"
spoke_subnets = {
  sn-dev-vm = {
    address_prefixes = ["10.0.1.0/27"]
  }
  sn-pe = {
    address_prefixes = ["10.0.1.32/27"]
  }
}

spoke_subscription_id = "1cec5258-8248-4460-80f9-0731a12caadf"

# ROUTING
#route_table_name         = "rt-dev-vm"
#default_route_name       = "default-to-firewall"

# Storage
storage_account_prefix = "stdev"

pe_sub_resource = "file"

private_endpoint_config = {

  storage_blob = {
    target_resource_key = "storage"

    subnet_name       = "sn-pe"
    subresource_names = ["blob"]
    dns_zone_key      = "blob"
  }

  storage_file = {
    target_resource_key = "storage"

    subnet_name       = "sn-pe"
    subresource_names = ["file"]
    dns_zone_key      = "file"
  }
}

hub_workspace_name        = "law-hub-prod"
hub_workspace_rg          = "rg-network-hub"
dev_vnet_diagnostics_name = "diag-dev-vnet"