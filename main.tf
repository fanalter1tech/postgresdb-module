# Creates RG dynamically
resource "azurerm_resource_group" "this" {
  count    = "${length(var.regions)}"
  name     = "azurerm-rg-${var.env_name}-${count.index}"
  location = "${var.regions[count.index]}"

  tags = var.tags
}

# Creates PostgreSQL Server
resource "azurerm_postgresql_server" "this" {
  count                        = "${length(var.regions)}"
  name                         = "azurerm-pg-server-${var.env_name}-${count.index}"
  location                     = "${azurerm_resource_group.this.*.location[count.index]}"
  resource_group_name          = "${azurerm_resource_group.this.*.name[count.index]}"
  version                      = "9.5"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_login_password

  tags = var.tags
}

# Creates PostgreSQL Server Firewall
resource "azurerm_postgresql_firewall_rule" "this" {
  count               = "${length(var.regions)}"
  name                = "azurerm-pg-firewall-${var.env_name}"
  resource_group_name = "${azurerm_resource_group.this.*.name[count.index]}"
  server_name         = "${azurerm_postgresql_server.this.*.name[count.index]}"
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address

  tags = var.tags
}

# Creates PostgreSQL Database
resource "azurerm_postgresql_database" "this" {
  name                = "azurerm-pg-db-${var.env_name}"
  resource_group_name = "${azurerm_resource_group.this.*.name[0]}"
  server_name         = "${azurerm_postgresql_server.this.*.name[0]}"
  charset             = var.charset
  collation           = var.collation

  tags = var.tags
}