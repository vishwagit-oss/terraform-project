module "rgroup" {
  source = "./modules/rgroup-n01645439"
  location = "East US"
}

module "network-n01645439" {
  source               = "./modules/network-n01645439"
  vnet_name            = "5439-vnet"
  vnet_address_space   = ["10.0.0.0/16"]
  subnet_name          = "5439-subnet"
  subnet_address_prefix = "10.0.1.0/24"
  nsg_name             = "5439-nsg"
  location             = "East US"
  resource_group_name  = module.rgroup.resource_group_name
}

module "common-services-n01645439" {
  source              = "./modules/common-services-n01645439"
  location            = "East US"
  resource_group_name = module.rgroup.resource_group_name
}

module "linux-vms-n01645439" {
  source              = "./modules/linux-vms-n01645439"
  rg_name             = module.rgroup.resource_group_name  
  subnet_id           = module.network-n01645439.subnet_id 
}
