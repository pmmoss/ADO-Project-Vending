# Service Principal Configuration
subscription = {
  subscription_id   = "your-subscription-id"
  subscription_name = "your-subscription-name"
  tenant_id        = "your-tenant-id"
  role_assignments = ["Contributor"]
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
      "PROJECT_NAME" = "simple-rg-project"
      "LOCATION" = "eastus"
      "RESOURCE_GROUP_NAME" = "rg-simple-project"
      "TAGS" = "{\"Environment\":\"Development\",\"Project\":\"SimpleRG\"}"
    }
  }
}

# Pipeline Configuration
pipelines = {
  "resource-group" = {
    name = "resource-group"
    description = "Pipeline to create and manage resource group"
    repository = {
      name = "simple-rg-project"
      branch = "main"
    }
    variables = {
      "TF_WORKSPACE" = "default"
      "TF_VAR_location" = "eastus"
      "TF_VAR_resource_group_name" = "rg-simple-project"
    }
  }
} 