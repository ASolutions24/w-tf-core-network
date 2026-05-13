nsgs = {
  "nsg-management" = {
    name                = "nsg-management"
    resource_group_name = "rg-network-hub"
  }
}

rules = {
  "nsg-management" = [
    {
      name                       = "allow-http"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

hub_subscription_id      = "39aca73e-1d25-4edf-84d5-ebe0397a816b"