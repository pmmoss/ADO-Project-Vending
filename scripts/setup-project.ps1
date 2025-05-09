param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$true)]
    [string]$SubscriptionId,
    
    [Parameter(Mandatory=$true)]
    [string]$TenantId,
    
    [Parameter(Mandatory=$false)]
    [string]$Location = "eastus",
    
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "rg-$ProjectName"
)

# Create project directory if it doesn't exist
$projectDir = "environments/projects/$ProjectName"
New-Item -ItemType Directory -Force -Path $projectDir

# Copy template configuration
Copy-Item "environments/templates/project-config.yaml" "$projectDir/config.yaml"

# Create variable groups file (this will be gitignored)
$varGroupsContent = @"
# Azure DevOps Variable Groups Configuration
# This file contains sensitive information and should not be committed to git

variable_groups:
  common-variables:
    name: "common-variables"
    description: "Common variables for all environments"
    variables:
      PROJECT_NAME: "$ProjectName"
      LOCATION: "$Location"
      RESOURCE_GROUP_NAME: "$ResourceGroupName"
      TAGS: '{"Environment":"Development","Project":"$ProjectName"}'

  sensitive-variables:
    name: "sensitive-variables"
    description: "Sensitive variables (subscription IDs, etc.)"
    variables:
      AZURE_SUBSCRIPTION_ID: "$SubscriptionId"
      AZURE_TENANT_ID: "$TenantId"
"@

$varGroupsContent | Out-File "$projectDir/variable-groups.yaml" -Encoding UTF8

Write-Host "Project configuration created in $projectDir"
Write-Host "Please review and update the following files:"
Write-Host "1. $projectDir/config.yaml - Update non-sensitive configuration"
Write-Host "2. $projectDir/variable-groups.yaml - Review sensitive variables"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Add variable-groups.yaml to .gitignore"
Write-Host "2. Create the variable groups in Azure DevOps"
Write-Host "3. Run the pipeline with the new configuration" 