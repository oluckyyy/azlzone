variable "location" {
  description = "Azure region"
  type        = string
}

variable "rg_hub" {
  description = "Resource group name for the hub network"
  type        = string
}

variable "rg_spoke" {
  description = "Resource group name for the spoke network"
  type        = string
}

variable "vnet_hub" {
  description = "Virtual Network name for the hub"
  type        = string
}

variable "vnet_spoke" {
  description = "Virtual Network name for the spoke"
  type        = string
}
