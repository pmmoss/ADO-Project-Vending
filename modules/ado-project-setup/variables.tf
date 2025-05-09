variable "ado_org_url" {
  description = "Azure DevOps organization URL"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "project_name" {
  description = "Name of the Azure DevOps project"
  type        = string
}

variable "project_description" {
  description = "Description of the Azure DevOps project"
  type        = string
  default     = "Project created and managed by Terraform"
}

variable "project_visibility" {
  description = "Visibility of the Azure DevOps project"
  type        = string
  default     = "private"
}

variable "service_principal_id" {
  description = "Service Principal ID for Azure DevOps service connection"
  type        = string
}

variable "service_principal_key" {
  description = "Service Principal Key for Azure DevOps service connection"
  type        = string
  sensitive   = true
}

variable "subscription_name" {
  description = "Name of the Azure subscription"
  type        = string
}

variable "service_principal_roles" {
  description = "List of roles to assign to the service principal"
  type        = list(string)
  default     = ["Contributor"]
}

variable "variable_groups" {
  description = "Map of variable groups to create"
  type = map(object({
    name        = string
    description = optional(string, "Managed by Terraform")
    variables   = map(string)
    allow_access = optional(bool, true)
  }))
  default = {}
} 