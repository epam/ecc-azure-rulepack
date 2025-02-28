resource "azurerm_public_ip" "this" {
  name                = "${var.prefix}-ip-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_lb" "this" {
  name                = "${var.prefix}-lb-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  frontend_ip_configuration {
    name                 = "${var.prefix}-front-red"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id      = azurerm_lb.this.id
  name                 = "${var.prefix}-red-pool"
}

