variable "location" {
  description = "Default Azure region for policy-related resources"
  type        = string
}

variable "management_group_id" {
  description = "Management group ID where policies will be assigned"
  type        = string
}

variable "log_analytics_id" {
  description = "Log Analytics Workspace ID for diagnostics"
  type        = string
}
