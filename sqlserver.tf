resource "azurerm_sql_server" "sql_server" {
  name                         = local.sql_server_name
  resource_group_name          = azurerm_resource_group.resource_group.name
  location                     = azurerm_resource_group.resource_group.location
  version                      = "12.0"
  administrator_login          = local.sql_server_administrator_login
  administrator_login_password = local.sql_server_administrator_password
}

resource "azurerm_sql_firewall_rule" "sql_firewall_rule" {
  name                = local.sql_firewall_rule_name
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_sql_server.sql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_virtual_network_rule" "sql_virtual_network_rule" {
  name                = local.sql_virtual_network_rule_name
  resource_group_name = azurerm_resource_group.resource_group.name
  server_name         = azurerm_sql_server.sql_server.name
  subnet_id           = azurerm_subnet.private.id
}

resource "azurerm_sql_database" "sql_database" {
  name                = local.sql_database_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  server_name         = azurerm_sql_server.sql_server.name
  edition             = "Basic"
}
