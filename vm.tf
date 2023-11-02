resource "azurerm_network_interface" "vm_network_interface" {
  name                = local.vm_network_interface
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "vm_ip_configuration"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = local.vm_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  size                = "Standard_D2s_v3"
  admin_username      = local.vm_admin_username
  admin_password      = local.vm_admin_password
  network_interface_ids = [
    azurerm_network_interface.vm_network_interface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# IISインストールできず。
# resource "azurerm_virtual_machine_extension" "vm_extension_install_iis" {
#   name                 = "vm_extension_install_iis"
#   virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.8"

#   settings = <<SETTINGS
#     {
#         "commandToExecute": "powershell Add-WindowsFeature Web-Server,Web-Asp-Net45,NET-Framework-Features"
#     }
# SETTINGS
# }

