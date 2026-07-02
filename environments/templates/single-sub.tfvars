# Service Principal Configuration
subscription = {
  subscription_id   = "your-subscription-id"
  subscription_name = "your-subscription-name"
  tenant_id        = "your-tenant-id"
  role_assignments = ["Contributor", "Network Contributor"]
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
      "PROJECT_NAME" = "Demo-Project-TF"
      "LOCATION" = "eastus"
    }
  }
} 