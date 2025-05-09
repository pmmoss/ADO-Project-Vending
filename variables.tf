variable "ado_org_service_url" {
  description = "Azure DevOps organization URL (e.g., https://dev.azure.com/your-org)"
  type        = string
}

variable "project_name" {
  description = "Name of the Azure DevOps project"
  type        = string
}

variable "project_description" {
  description = "Description of the Azure DevOps project"
  type        = string
  default     = "Project created via Terraform"
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "azure_subscription_name" {
  description = "Azure Subscription Name"
  type        = string
}

variable "github_repo_id" {
  description = "GitHub Repository ID"
  type        = string
}

variable "github_enterprise_url" {
  description = "GitHub Enterprise URL (if using GitHub Enterprise)"
  type        = string
  default     = "https://github.com"
} 