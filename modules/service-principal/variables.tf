variable "subscription" {
  description = "Single subscription configuration"
  type = object({
    subscription_id   = string
    subscription_name = string
    tenant_id        = string
    role_assignments = optional(list(string), ["Contributor"])
  })
  default = null
}

variable "subscriptions" {
  description = "Map of subscription configurations for multiple subscriptions"
  type = map(object({
    subscription_id   = string
    subscription_name = string
    tenant_id        = string
    role_assignments = optional(list(string), ["Contributor"])
  }))
  default = {}
}

variable "service_principal_name" {
  description = "Name of the service principal"
  type        = string
}

variable "service_principal_description" {
  description = "Description of the service principal"
  type        = string
  default     = "Service Principal created and managed by Terraform"
}

variable "project_id" {
  description = "Azure DevOps project ID"
  type        = string
} 