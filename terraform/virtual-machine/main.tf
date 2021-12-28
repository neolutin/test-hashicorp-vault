# Make client_id, tenant_id, subscription_id and object_id variables
data "azurerm_client_config" "current" {}

resource "azurerm_linux_virtual_machine" "main" {
  name                 = "${var.suffix}"
  resource_group_name  = var.resource_group_name
  location             = var.location
  size                 = "Standard_A1_v2"
  admin_username       = "adminuser"
  availability_set_id  = var.availability_set_id
  tags                 = var.tags

  network_interface_ids = [
    azurerm_network_interface.main.id,
    azurerm_network_interface.internal.id,
  ]

  admin_ssh_key {
    username = "adminuser"
    public_key = file("../.ssh/id_rsa.pub")
  }
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

resource "azurerm_virtual_machine_extension" "installvault" {
  name                 = "installvault"
  virtual_machine_id   = azurerm_linux_virtual_machine.main.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

    protected_settings = <<PROT
    {
        "script": "${base64encode(file("setupvm.sh"))}"
    }
    PROT
  tags = var.tags
}
