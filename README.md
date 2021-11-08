# Hashicorp Vault
CI/Automation project to create the infrastructure and setup an Hashicorp Vault

# Manual Setup
* Create Terraform Storage Account (once for all terraform projects)
* Create specific container (to be done for each project)
* Register Azure resource providers (Microsoft.Network, Microsoft.Compute, Microsoft.KeyVault...)
* Create GitHub Secrets
* Create an AAD App Registration for terraform
  * with delegated Microsoft Graph User.Read
  * with application Microsoft Graph Application.ReadWrite.All & Directory.ReadWrite.All
  * Add it as owner of the subscription
* Create an AAD App Registration for ansible

# Automaticaly done
* Creation of a linux VM with vault installed in an availability set
* Deployment of the vault configuration on this VM

# Todo
* Use ansible playbook for configuration (setup-vault)
* Hardenning
  * Segregate app usage (only one is used)
  * Connect from github to Azure vault to get sensitive data
  * Fine tune the role of the app on the azure subscription
  * Use VM MSI for Azure Vault authentification
* HA
  * Add an [Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/overview) (L7 load balancing)
  * Add a second VM
  * Configure the vault cluster


