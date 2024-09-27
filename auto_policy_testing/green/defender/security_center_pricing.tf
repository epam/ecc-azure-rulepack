resource "azurerm_security_center_subscription_pricing" "servers" {
  tier          = "Standard"
  resource_type = "VirtualMachines"
}

resource "azurerm_security_center_subscription_pricing" "app" {
  tier          = "Standard"
  resource_type = "AppServices"
}

resource "azurerm_security_center_subscription_pricing" "azure_sql" {
  tier          = "Standard"
  resource_type = "SqlServers"
}

resource "azurerm_security_center_subscription_pricing" "sql_machines" {
  tier          = "Standard"
  resource_type = "SqlServerVirtualMachines"
  depends_on = [ azurerm_security_center_subscription_pricing.azure_sql ]
}

resource "azurerm_security_center_subscription_pricing" "storages" {
  tier          = "Standard"
  resource_type = "StorageAccounts"
}

resource "azurerm_security_center_subscription_pricing" "aks" {
  tier          = "Standard"
  resource_type = "KubernetesService"
}

resource "azurerm_security_center_subscription_pricing" "acr" {
  tier          = "Standard"
  resource_type = "ContainerRegistry"
}

resource "azurerm_security_center_subscription_pricing" "keyvaults" {
  tier          = "Standard"
  resource_type = "KeyVaults"
}

resource "azurerm_security_center_subscription_pricing" "dns" {
  tier          = "Standard"
  resource_type = "Dns"
}

resource "azurerm_security_center_subscription_pricing" "arm" {
  tier          = "Standard"
  resource_type = "Arm"
}

resource "azurerm_security_center_subscription_pricing" "os_rds" {
  tier          = "Standard"
  resource_type = "OpenSourceRelationalDatabases"
  depends_on = [ azurerm_security_center_subscription_pricing.sql_machines ]
}

resource "azurerm_security_center_subscription_pricing" "cosmodb" {
  tier          = "Standard"
  resource_type = "CosmosDbs"
  depends_on = [ azurerm_security_center_subscription_pricing.os_rds ]
}

