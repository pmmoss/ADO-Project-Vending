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

provider "azurerm" {
  features {}
}

provider "azuredevops" {
  org_service_url       = var.ado_org_service_url
  use_managed_identity  = true
}

# Create a new Azure DevOps project
resource "azuredevops_project" "project" {
  name               = var.project_name
  description        = var.project_description
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
}

# Create Azure service connection using managed identity
resource "azuredevops_serviceendpoint_azurerm" "azure" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "Azure"
  use_managed_identity  = true
  azurerm_spn_tenantid      = var.azure_tenant_id
  azurerm_subscription_id   = var.azure_subscription_id
  azurerm_subscription_name = var.azure_subscription_name
}

# Create GitHub service connection using managed identity
resource "azuredevops_serviceendpoint_github_enterprise" "github" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "GitHub"
  use_managed_identity  = true
  github_enterprise_url = var.github_enterprise_url
}

# Create build pipeline
resource "azuredevops_build_definition" "build" {
  project_id = azuredevops_project.project.id
  name       = "Build Pipeline"
  path       = "\\"

  repository {
    repo_type   = "GitHub"
    repo_id     = var.github_repo_id
    branch_name = "main"
    yml_path    = "azure-pipelines.yml"
  }

  variable_groups = [
    azuredevops_variable_group.variables.id
  ]
}

# Create variable group
resource "azuredevops_variable_group" "variables" {
  project_id   = azuredevops_project.project.id
  name         = "Build Variables"
  description  = "Variables for build pipeline"
  allow_access = true

  variable {
    name  = "BUILD_CONFIGURATION"
    value = "Release"
  }
} 