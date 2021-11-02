resource "azurerm_resource_group" "main" {
  name     = "resources-${terraform.workspace}-${var.suffix}"
  location = "westeurope"
  tags     = var.tags
}

resource "azurerm_availability_set" "availability" {
  name                = "aset-${terraform.workspace}-${var.suffix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

module "vm1" {
  source              = "./virtual-machine"
  suffix              = "vm1-${terraform.workspace}-${var.suffix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  availability_set_id = azurerm_availability_set.availability.id
  subnet_id           = azurerm_subnet.internal.id
  security_group_id   = azurerm_network_security_group.vault.id
  tags                = var.tags
}

output "vm1_ip_addr" {
  value = module.vm1.vm_ip_addr
}
