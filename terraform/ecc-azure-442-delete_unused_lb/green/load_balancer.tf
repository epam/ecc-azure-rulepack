resource "azurerm_public_ip" "this" {
  name                = "${var.prefix}-ip-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_lb" "this" {
  name                = "${var.prefix}-lb-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${var.prefix}-front-green"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id      = azurerm_lb.this.id
  name                 = "${var.prefix}-green-pool"
}

resource "azurerm_lb_backend_address_pool" "additional" {
  loadbalancer_id      = azurerm_lb.this.id
  name                 = "${var.prefix}-green-pool-additional"
}

resource "azurerm_lb_probe" "this" {
  loadbalancer_id     = azurerm_lb.this.id
  name                = "${var.prefix}-green-probe"
  port                = 80
}

resource "azurerm_lb_rule" "this" {
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "${var.prefix}-test-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  disable_outbound_snat          = true
  frontend_ip_configuration_name = "${var.prefix}-front-green"
  probe_id                       = azurerm_lb_probe.this.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
}

resource "azurerm_lb_outbound_rule" "this" {
  name                    = "${var.prefix}-green-outbound"
  loadbalancer_id         = azurerm_lb.this.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id

  frontend_ip_configuration {
    name = "${var.prefix}-front-green"
  }
}

