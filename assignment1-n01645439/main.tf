module "rgroup" {
  source   = "./modules/rgroup-n01645439"
  location = "East US"
  tags     = local.common_tags
}

module "network-n01645439" {
  source                = "./modules/network-n01645439"
  vnet_name             = "5439-vnet"
  vnet_address_space    = ["10.0.0.0/16"]
  subnet_name           = "5439-subnet"
  subnet_address_prefix = "10.0.1.0/24"
  nsg_name              = "5439-nsg"
  location              = "East US"
  resource_group_name   = module.rgroup.resource_group_name
  tags                  = local.common_tags
}

module "common-services-n01645439" {
  source              = "./modules/common-services-n01645439"
  location            = "East US"
  resource_group_name = module.rgroup.resource_group_name
  tags                = local.common_tags
}

module "linux-vms-n01645439" {
  source              = "./modules/linux-vms-n01645439"
  location            = "East US"
  rg_name             = module.rgroup.resource_group_name
  subnet_id           = module.network-n01645439.subnet_id
  storage_account_uri = module.common-services-n01645439.storage_account_primary_blob_endpoint
  admin_username      = "n01645439"
  tags                = local.common_tags
}

module "windows-vms-n01645439" {
  source              = "./modules/windows-vms-n01645439"
  location            = "East US"
  resource_group_name = module.rgroup.resource_group_name
  vm_count            = 1
  admin_username      = "n01645439"
  admin_password      = "n01645439!23"
  storage_account_url = module.common-services-n01645439.storage_account_primary_blob_endpoint
  subnet_id           = module.network-n01645439.subnet_id
  tags                = local.common_tags
}

module "data-disks-n01645439" {
  source              = "./modules/data-disks-n01645439"
  location            = "East US"
  resource_group_name = module.rgroup.resource_group_name
  vm_ids              = concat(module.linux-vms-n01645439.vm_ids, module.windows-vms-n01645439.vm_ids)
  tags                = local.common_tags

}

module "load-balancer-n01645439" {
  source              = "./modules/load-balancer-n01645439"
  location            = "East US"
  resource_group_name = module.rgroup.resource_group_name
  vm_nic_ids          = module.linux-vms-n01645439.vm_nics
  tags                = local.common_tags
}

module "database-n01645439" {
  source              = "./modules/database-n01645439"
  location            = "East US"
  resource_group_name = module.rgroup.resource_group_name
  db_server_name      = "n01645439-pg-server"
  db_admin_username   = "n01645439"
  db_admin_password   = "adminPswd!5439"
  db_name             = "n01645439-mydatabase"
  tags                = local.common_tags
}