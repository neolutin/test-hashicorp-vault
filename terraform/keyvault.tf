resource "azurerm_key_vault" "main_kv" {
  name                        = "kv-${terraform.workspace}-${var.suffix}"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  tags     = var.tags
  
  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

resource "azurerm_key_vault_access_policy" "main_kv_open_policy" {
  key_vault_id = azurerm_key_vault.main_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "Set", "Delete", "Purge"
  ]
  key_permissions    = [
    "create",
    "get",
    "purge",
    "recover",
    "wrapKey",
    "unwrapKey",
  ]
  certificate_permissions = []
  storage_permissions     = []
}

resource "random_password" "password" {
  length           = 20
  special          = true
  override_special = "_%@"
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
}

resource "azurerm_key_vault_key" "vaultkey" {
  name         = "vaultkey"
  key_vault_id = azurerm_key_vault.main_kv.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_key_vault_secret" "simple_user_password" {
  name         = "simplepassword"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.main_kv.id
}

output "simple_password" {
  sensitive = true
  value = azurerm_key_vault_secret.simple_user_password
}
