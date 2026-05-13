module "nsg_rules" {
  source = "../../../modules/nsg-rules"

  nsgs  = var.nsgs
  rules = var.rules
}