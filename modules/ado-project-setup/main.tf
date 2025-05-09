terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Azure DevOps Provider configuration
provider "azuredevops" {
  org_service_url = var.ado_org_url
}

# Azure Provider configuration
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Create Azure DevOps Project
resource "azuredevops_project" "project" {
  name               = var.project_name
  description        = var.project_description
  visibility         = var.project_visibility
  version_control    = "Git"
  work_item_template = "Agile"
}

# Create Service Principal and Service Connection
module "service_principal" {
  source = "../service-principal"

  tenant_id                  = var.tenant_id
  subscription_id           = var.subscription_id
  subscription_name         = var.subscription_name
  service_principal_name    = "${var.project_name}-sp"
  service_principal_description = "Service Principal for ${var.project_name}"
  role_assignments          = var.service_principal_roles
  project_id                = azuredevops_project.project.id
}

# Create Variable Groups
resource "azuredevops_variable_group" "variable_groups" {
  for_each = var.variable_groups

  project_id   = azuredevops_project.project.id
  name         = each.value.name
  description  = each.value.description
  allow_access = each.value.allow_access

  dynamic "variable" {
    for_each = each.value.variables
    content {
      name  = variable.key
      value = variable.value
    }
  }
} 