variable "suffix" {
  description = "The suffix which should be used for all resources in this example"
}

variable "tags" {
    type = map
    default = {
      "Terraform" = "true"
    }
    description = "Azure Resource Tags"
}
