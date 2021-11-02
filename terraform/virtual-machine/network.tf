resource "azurerm_public_ip" "pip" {
  name                = "pip-${var.suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = var.tags
}

resource "azurerm_network_interface" "main" {
  name                = "nic1-${var.suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_interface" "internal" {
  name                      = "nic2-${var.suffix}"
  resource_group_name       = var.resource_group_name
  location                  = var.location

  tags = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.internal.id
  network_security_group_id = var.security_group_id
}
