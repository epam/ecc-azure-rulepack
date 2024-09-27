resource "azurerm_security_center_subscription_pricing" "servers" {
  tier          = "Free"
  resource_type = "VirtualMachines"
}

resource "azurerm_security_center_subscription_pricing" "app" {
  tier          = "Free"
  resource_type = "AppServices"
}

resource "azurerm_security_center_subscription_pricing" "azure_sql" {
  tier          = "Free"
  resource_type = "SqlServers"
}

resource "azurerm_security_center_subscription_pricing" "sql_machines" {
  tier          = "Free"
  resource_type = "SqlServerVirtualMachines"
}

resource "azurerm_security_center_subscription_pricing" "storages" {
  tier          = "Free"
  resource_type = "StorageAccounts"
}

resource "azurerm_security_center_subscription_pricing" "aks" {
  tier          = "Free"
  resource_type = "KubernetesService"
}

resource "azurerm_security_center_subscription_pricing" "acr" {
  tier          = "Free"
  resource_type = "ContainerRegistry"
}

resource "azurerm_security_center_subscription_pricing" "keyvaults" {
  tier          = "Free"
  resource_type = "KeyVaults"
}

resource "azurerm_security_center_subscription_pricing" "dns" {
  tier          = "Free"
  resource_type = "Dns"
}

resource "azurerm_security_center_subscription_pricing" "arm" {
  tier          = "Free"
  resource_type = "Arm"
}

resource "azurerm_security_center_subscription_pricing" "os_rds" {
  tier          = "Free"
  resource_type = "OpenSourceRelationalDatabases"
}

resource "azurerm_security_center_subscription_pricing" "cosmodb" {
  tier          = "Free"
  resource_type = "CosmosDbs"
}

