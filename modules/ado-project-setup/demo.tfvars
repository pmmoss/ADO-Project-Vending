# Service Principal Configuration
subscriptions = {
  "dev" = {
    subscription_id   = "your-dev-subscription-id"
    subscription_name = "your-dev-subscription-name"
    tenant_id        = "your-dev-tenant-id"
    role_assignments = ["Contributor", "Network Contributor"]
  }
  "qa" = {
    subscription_id   = "your-qa-subscription-id"
    subscription_name = "your-qa-subscription-name"
    tenant_id        = "your-qa-tenant-id"
    role_assignments = ["Contributor"]
  }
  "prod" = {
    subscription_id   = "your-prod-subscription-id"
    subscription_name = "your-prod-subscription-name"
    tenant_id        = "your-prod-tenant-id"
    role_assignments = ["Contributor"]
  }
  "shared" = {
    subscription_id   = "your-shared-subscription-id"
    subscription_name = "your-shared-subscription-name"
    tenant_id        = "your-shared-tenant-id"
    role_assignments = ["Contributor", "Network Contributor"]
  }
}

service_principal_name = "ado-service-connection"
service_principal_description = "Service Principal for Azure DevOps service connection"
project_id = "your-project-id"

# Variable Groups Configuration
variable_groups = {
  "common-variables" = {
    name = "common-variables"
    description = "Common variables for all environments"
    variables = {
      "PROJECT_NAME" = "your-project-name"
      "LOCATION" = "eastus"
    }
  }
  "dev-variables" = {
    name = "dev-variables"
    description = "Development environment variables"
    variables = {
      "ENVIRONMENT" = "dev"
      "RESOURCE_GROUP" = "rg-dev"
      "SUBSCRIPTION_ID" = "your-dev-subscription-id"
    }
  }
  "qa-variables" = {
    name = "qa-variables"
    description = "QA environment variables"
    variables = {
      "ENVIRONMENT" = "qa"
      "RESOURCE_GROUP" = "rg-qa"
      "SUBSCRIPTION_ID" = "your-qa-subscription-id"
    }
  }
  "prod-variables" = {
    name = "prod-variables"
    description = "Production environment variables"
    variables = {
      "ENVIRONMENT" = "prod"
      "RESOURCE_GROUP" = "rg-prod"
      "SUBSCRIPTION_ID" = "your-prod-subscription-id"
    }
  }
}