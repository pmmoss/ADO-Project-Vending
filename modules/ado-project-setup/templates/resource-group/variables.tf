variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to the resource group"
  type        = map(string)
  default     = {
    Environment = "Development"
    Project     = "SimpleRG"
  }
} 