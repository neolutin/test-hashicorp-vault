variable "suffix" {
  description = "The suffix which should be used for all resources in this example"
}

variable "location" {
  description = "The Azure Region in which all resources should be created."
}

variable "resource_group_name" {
  description = "The resource group hosting all created resources."
  type = string
}

variable "availability_set_id" {
  description = "The availability set id in which VM will run."
}

variable "subnet_id" {
  description = "The subnet id for created VM."
}

variable "security_group_id" {
  description = "The network security group ID to apply to the VM nic."
}

variable "tags" {
    type = map
    default = {
      "Terraform" = "true"
    }
    description = "Azure Resource Tags"
}
