resource "azurerm_resource_group" "main" {
  name     = "resources-${var.suffix}"
  location = "westeurope"
  tags     = var.tags
}

resource "azurerm_virtual_network" "main" {
  name                = "network-${var.suffix}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_availability_set" "availability" {
  name                = "aset-${var.suffix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

module "vm1" {
  source              = "./virtual-machine"
  suffix              = "vm1-${var.suffix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  availability_set_id = azurerm_availability_set.availability.id
  subnet_id           = azurerm_subnet.internal.id
  tags                = var.tags
}

module "vm2" {
  source              = "./virtual-machine"
  resource_group_name = azurerm_resource_group.main.name
  location            = "northeurope"
  availability_set_id = azurerm_availability_set.availability.id
  suffix              = "vm2-${var.suffix}"
  subnet_id           = azurerm_subnet.internal.id
  tags                = var.tags
}
