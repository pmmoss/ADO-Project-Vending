# Azure DevOps Project Setup with Terraform

This Terraform configuration helps you set up a new Azure DevOps project with all necessary service connections and build pipelines using managed identities for authentication.

## Quick Start (Pipeline Only)

1. **Create a new repository in Azure DevOps**
   - Create a new repository
   - Upload all the files from this project to your repository

2. **Create the Pipeline**
   - Go to Pipelines → New Pipeline
   - Select "Azure Repos Git" (your repository)
   - Choose "Existing Azure Pipelines YAML file"
   - Select `/azure-pipelines.yml`
   - Click "Save and run"

3. **Set up Azure Service Connection**
   - Go to Project Settings → Service connections
   - Create a new Azure Resource Manager service connection
   - Grant access permission to all pipelines

## Configuration Options

You can configure the pipeline in two ways:

### 1. Using Pipeline Parameters (Recommended)

When running the pipeline, you can provide parameters through the Azure DevOps UI:
- `ado_org_service_url`: Your Azure DevOps organization URL
- `project_name`: Name of the project to create
- `project_description`: Project description (default: "Project created via Terraform")
- `github_repo_id`: GitHub repository ID
- `github_enterprise_url`: GitHub Enterprise URL (default: "https://github.com")
- `azure_tenant_id`: Azure tenant ID
- `azure_subscription_id`: Azure subscription ID
- `azure_subscription_name`: Azure subscription name

### 2. Using terraform.tfvars

Alternatively, you can create a `terraform.tfvars` file in your repository:
```hcl
ado_org_service_url = "https://dev.azure.com/your-org"
project_name        = "my-project"
project_description = "My Azure DevOps Project"

github_repo_id      = "your-github-repo-id"
github_enterprise_url = "https://github.com"

azure_tenant_id        = "your-azure-tenant-id"
azure_subscription_id  = "your-azure-subscription-id"
azure_subscription_name = "your-azure-subscription-name"
```

The pipeline will:
1. Use parameters if provided
2. Fall back to terraform.tfvars if parameters are not provided
3. Create or update terraform.tfvars with the final values

## What You Need

1. **Azure DevOps Organization**
   - Your organization URL
   - Project creation permissions

2. **Azure Subscription**
   - Subscription ID
   - Tenant ID
   - Subscription Name
   - Contributor permissions

3. **GitHub Repository** (if using GitHub)
   - Repository ID
   - Repository access

## What This Creates

- A new Azure DevOps project
- GitHub service connection using managed identity
- Azure service connection using managed identity
- Build pipeline
- Variable group for build configuration

## Security Notes

- Uses managed identities instead of PAT tokens
- No sensitive credentials stored in configuration
- All authentication handled through Azure managed identities
- Terraform state stored in Azure Storage with proper access controls
- Variables can be provided through secure pipeline parameters

## Troubleshooting

If you encounter any issues:

1. Check pipeline logs for detailed error messages
2. Verify parameter values or terraform.tfvars values are correctly set
3. Ensure the Azure service connection is properly configured
4. Verify you have the necessary permissions in Azure DevOps
5. Check that your GitHub repository is accessible (if using GitHub)

## Support

For issues or questions, please create an issue in this repository. 