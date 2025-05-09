terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

locals {
  # Combine single subscription and multiple subscriptions into a single map
  all_subscriptions = merge(
    var.subscription != null ? { "default" = var.subscription } : {},
    var.subscriptions
  )
  
  # Get the first subscription's tenant ID for provider configuration
  first_subscription = var.subscription != null ? var.subscription : values(var.subscriptions)[0]
}

# Azure AD Provider configuration
provider "azuread" {
  tenant_id = local.first_subscription.tenant_id
}

# Azure Provider configuration
provider "azurerm" {
  features {}
  tenant_id = local.first_subscription.tenant_id
}

# Create Service Principal
resource "azuread_application" "app" {
  display_name = var.service_principal_name
  description  = var.service_principal_description
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.application_id
  use_existing = false
}

# Assign roles to Service Principal for each subscription
resource "azurerm_role_assignment" "contributor" {
  for_each = {
    for assignment in flatten([
      for sub_name, sub in local.all_subscriptions : [
        for role in sub.role_assignments : {
          subscription_id = sub.subscription_id
          role           = role
        }
      ]
    ]) : "${assignment.subscription_id}-${assignment.role}" => assignment
  }

  scope                = each.value.subscription_id
  role_definition_name = each.value.role
  principal_id         = azuread_service_principal.sp.id
}

# Create Azure DevOps Service Connection for each subscription
resource "azuredevops_serviceendpoint_azurerm" "service_connection" {
  for_each = local.all_subscriptions

  project_id            = var.project_id
  service_endpoint_name = "${var.service_principal_name}-${each.key}-service-connection"
  description           = "Managed by Terraform for ${each.key} environment"
  
  credentials {
    serviceprincipalid  = azuread_service_principal.sp.id
  }

  azurerm_spn_tenantid      = each.value.tenant_id
  azurerm_subscription_id   = each.value.subscription_id
  azurerm_subscription_name = each.value.subscription_name
} 