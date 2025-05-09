# Service Principal Configuration
subscription = {
  subscription_id   = "e6358700-f24a-461f-887f-72554e3785af"
  subscription_name = "SUB-PMOSS-DEV"
  tenant_id        = "a9e613d6-49f9-499f-9bcf-e95f8f3bbbc8"
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