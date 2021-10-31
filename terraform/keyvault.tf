resource "azurerm_key_vault" "main_kv" {
  name                        = "kv-${var.suffix}"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  tags     = var.tags
}

resource "azurerm_key_vault_access_policy" "main_kv_open_policy" {
  key_vault_id = azurerm_key_vault.main_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "Set"
  ]
  certificate_permissions = []
  key_permissions         = []
  storage_permissions     = []
}

resource "random_password" "password1" {
  length           = 20
  special          = true
  override_special = "_%@"
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
}

resource "random_password" "password2" {
  length           = 20
  special          = true
  override_special = "_%@"
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
}

resource "azurerm_key_vault_secret" "vault_key" {
  name         = "vaultkey"
  value        = random_password.password1.result
  key_vault_id = azurerm_key_vault.main_kv.id
}

resource "azurerm_key_vault_secret" "simple_user_password" {
  name         = "simplepassword"
  value        = random_password.password2.result
  key_vault_id = azurerm_key_vault.main_kv.id
}

output "simple_password" {
  sensitive = true
  value = azurerm_key_vault_secret.simple_user_password
}
