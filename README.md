# Azure DevOps Project Setup

This tool helps you create new Azure DevOps projects with all the necessary setup automatically.

## What You Need

1. Your Azure DevOps organization URL (like https://dev.azure.com/your-company)
2. Your Azure subscription ID
3. Your Azure tenant ID

## How to Use

### Step 1: Configure Common Variables
1. Go to the `config/variable-groups` folder
2. Edit `common-variables.yaml` and fill in your organization details:
   ```yaml
   variables:
     ADO_ORG_URL: "https://dev.azure.com/your-organization"
     AZURE_SUBSCRIPTION: "your-subscription-name"
     ARM_SUBSCRIPTION_NAME: "your-subscription-name"
   ```

### Step 2: Create Project Configuration
1. Go to the `config` folder
2. Copy `project-template.yaml` to `config/projects/your-project-name.yaml`
3. Fill in your project details:
   ```yaml
   project_name: "Your Project Name"
   subscription_id: "your-subscription-id"
   tenant_id: "your-tenant-id"
   location: "eastus"  # Optional, defaults to eastus
   ```

### Step 3: Run the Pipeline
1. Go to Azure DevOps
2. Click "New Pipeline"
3. Choose "Existing Azure Pipelines YAML file"
4. Select the file: `pipelines/setup.yml`
5. Click "Run"

### Step 4: What Happens Next
The pipeline will automatically:
1. Create the common variable group
2. Create your new Azure DevOps project
3. Set up the necessary Azure connection
4. Create basic pipeline templates for:
   - Infrastructure deployment
   - Application deployment

## Need Help?
If you encounter any issues:
1. Make sure all required information is filled in correctly
2. Check that your Azure DevOps organization URL is correct
3. Verify your Azure subscription is active
4. Contact your DevOps team for assistance 