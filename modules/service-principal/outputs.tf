output "service_principal_id" {
  description = "The ID of the service principal"
  value       = azuread_service_principal.sp.id
}

output "service_principal_application_id" {
  description = "The application ID of the service principal"
  value       = azuread_application.app.application_id
}

output "service_connections" {
  description = "Map of service connection IDs by subscription"
  value       = {
    for k, v in azuredevops_serviceendpoint_azurerm.service_connection : k => v.id
  }
} 