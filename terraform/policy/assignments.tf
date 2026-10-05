# Look up the MG you want to target (e.g., "LandingZones")
data "azurerm_management_group" "mg" {
  name = var.management_group_id # example: "LandingZones"
}

# Deploy Azure Monitor Agent (DCR) to all VMs
resource "azurerm_management_group_policy_assignment" "deploy_azure_monitor_agent" {
  name                 = "Deploy-AMA-to-VMs"
  display_name         = "Deploy Azure Monitor Agent to VMs"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ca817e41-e85a-4783-bc7f-dc532d36235e"
  management_group_id  = data.azurerm_management_group.mg.id

  location = "eastus"

  identity {
    type = "SystemAssigned"
  }

  # Parameter name must match the built-in definition
  #parameters = jsonencode({
  #logAnalyticsWorkspaceResourceId = { value = var.log_analytics_id }
  #})

  #enforcement_mode = "Default"
}

# Configure diagnostic settings for Key Vaults
resource "azurerm_management_group_policy_assignment" "diagnostic_keyvault" {
  name                 = "Diag-KV-Mgmt"
  display_name         = "Deploy diagnostic settings for Key Vault"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/bef3f64c-5290-43b7-85b0-9b254eef4c47"
  management_group_id  = data.azurerm_management_group.mg.id

  location = "eastus"

  identity {
    type = "SystemAssigned"
  }

  parameters = jsonencode({
    logAnalytics = { value = var.log_analytics_id }
  })
}

# Enforce tags on all resources
resource "azurerm_management_group_policy_assignment" "require_tags" {
  name                 = "Require-Standard-Tags"
  display_name         = "Require resource tagging (environment, owner)"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
  management_group_id  = data.azurerm_management_group.mg.id

  parameters = jsonencode({
    tagName = { value = "environment" }
  })
}

# Grant the 'Diag-KV-Mgmt' Policy Identity Contributor role on the Log Analytics Workspace
resource "azurerm_role_assignment" "kv_diag_contributor" {
  # The scope is the Log Analytics Workspace ID
  scope = var.log_analytics_id

  # The identity of the policy assignment we just created
  principal_id = azurerm_management_group_policy_assignment.diagnostic_keyvault.identity[0].principal_id

  # The Role Definition ID (or Name) required to set up diagnostic settings
  role_definition_name = "Log Analytics Contributor"
}

# Grant the Policy Identities Contributor role on the Management Group Scope
resource "azurerm_role_assignment" "mg_contributor" {
  # The scope is the Management Group
  scope = data.azurerm_management_group.mg.id

  # Use the identity of one of the DINE policies, as they both need this high-level access
  # We'll use the AMA identity for this example.
  principal_id = azurerm_management_group_policy_assignment.deploy_azure_monitor_agent.identity[0].principal_id

  # Grant Contributor role so it can deploy/modify resources within the scope
  role_definition_name = "Contributor"

  # NOTE: To prevent conflicts, you must only create ONE role assignment resource 
  # per principal_id per scope (unless using different role definitions).
}
