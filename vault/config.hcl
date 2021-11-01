storage "raft" {
  path    = "/vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true"
  telemetry {
    unauthenticated_metrics_access = true
  }
}

seal "azurekeyvault" {
  tenant_id      = "__AZURETENANT_ID__"
  client_id      = "__TERRAFORMCLIENT_ID__"
  client_secret  = "__TERRAFORMCLIENT_SECRET__"
  vault_name     = "kv-__RESOURCES_NAME__"
  key_name       = "vaultkey"
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"
ui = true
disable_mlock = true
