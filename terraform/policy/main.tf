
# Define the custom policy definition to restrict resource locations

resource "azurerm_policy_definition" "restrict_location" {
  # This is the resource name (internal to Terraform state)
  name = "restrict-resource-locations"

  # These attributes correspond to the metadata/definition of the policy
  display_name = "Restrict resource locations to East US"
  policy_type  = "Custom"
  mode         = "All"
  description  = "Only resources in East US are allowed."

  # The 'policy_rule' attribute requires the JSON content of the rule itself.
  # The file() function reads the content of the separate JSON file.
  # CRITICAL FIX: The JSON in the file must start with "if" and "then", not "properties".
  policy_rule = file("${path.module}/custom_location_policy_rule.json")

  # Metadata is typically supplied as a JSON string
  metadata = jsonencode({
    version  = "1.0.0"
    category = "General"
  })

  # Since your policy logic (based on your JSON) doesn't use parameters, 
  # this block can be omitted, but keeping it empty is also valid:
  parameters = jsonencode({})
}


