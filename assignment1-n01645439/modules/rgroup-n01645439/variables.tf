variable "location" {
  description = "The Azure location where the resource group will be created."
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource group."
  type        = map(string)
  default = {
    owner = "terraform"
  }
}