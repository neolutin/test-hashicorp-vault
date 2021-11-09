# Hashicorp Vault
CI/Automation project to create the infrastructure and setup an Hashicorp Vault

# Manual Setup
* In Azure:
  * Create Terraform Storage Account (once for all terraform projects)
  * Create specific container (to be done for each project)
  * Register Azure resource providers (Microsoft.Network, Microsoft.Compute, Microsoft.KeyVault...)
  * Create an AAD App Registration for terraform
    * with delegated Microsoft Graph User.Read
    * with application Microsoft Graph Application.ReadWrite.All & Directory.ReadWrite.All
    * Add it as owner of the subscription
* In GitHub:
  * Create GitHub Secrets
  * Protect main branch by adding:
    * required PR
    * required status on step prodInfra
* terraform:
  * Create at least `staging` & `prod` workspaces

# Automaticaly done
* Creation of a linux VM with vault installed in an availability set
* Deployment of the vault configuration on this VM

# Todo
* Use ansible playbook for configuration (setup-vault)
* Hardenning
  * Create a dedicated app for azuread provider
  * Fine tune the role of the app on the azure subscription
  * Use VM MSI for Azure Vault authentification
* HA
  * Add an [Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/overview) (L7 load balancing)
  * Add a second VM
  * Configure the vault cluster


