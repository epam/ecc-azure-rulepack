output "webapp" {
  value = {
    #common webapp
    webapp = azurerm_linux_web_app.python1.id,
    #WEBAPP
    
    #java
    ecc-azure-069-11_cis_app_last_java = azurerm_linux_web_app.java1.id,
    ecc-azure-069-51_cis_app_last_java = azurerm_linux_web_app.java1.id,
    ecc-azure-501-cis_app_next_for_eol_java = azurerm_linux_web_app.java2.id,
    #python
    ecc-azure-070-51_cis_app_last_python = azurerm_linux_web_app.python2.id,
    ecc-azure-502-cis_app_next_for_eol_python = azurerm_linux_web_app.python2.id,
    #php
    ecc-azure-071-51_cis_app_last_php = azurerm_linux_web_app.php1.id,
    ecc-azure-503-cis_app_next_for_eol_php = azurerm_linux_web_app.php2.id,
    
    
    #common functionapp
    ecc-azure-180-asb_func_app_managed_identity = azurerm_linux_function_app.python1.id,
    ecc-azure-237-asb_cors_func = azurerm_linux_function_app.python1.id,
    ecc-azure-241-asb_certif_func = azurerm_linux_function_app.python1.id,
    ecc-azure-257-asb_remotedebug_func = azurerm_linux_function_app.python1.id,
    ecc-azure-258-asb_remotedebug_web = azurerm_linux_web_app.remdeb.id,
    ecc-azure-299-function_app_health_check = azurerm_linux_function_app.python1.id,

    #FUNCTIONAPP
    #java
    ecc-azure-267-11_asb_java_funcapp = azurerm_linux_function_app.java1.id,
    ecc-azure-267-51_asb_java_funcapp = azurerm_linux_function_app.java2.id,
    ecc-azure-504-asb_funcapp_next_for_eol_java = azurerm_linux_function_app.java2.id,
    #python
    ecc-azure-270-11_asb_python_funcapp = azurerm_linux_function_app.python1.id,
    ecc-azure-270-51_asb_python_funcapp = azurerm_linux_function_app.python2.id,
    ecc-azure-421-asb_deprecated_python_funcapp = azurerm_linux_function_app.python1.id,
    ecc-azure-505-asb_funcapp_next_for_eol_python = azurerm_linux_function_app.python2.id,
    #powershell
    ecc-azure-427-dep_powershell_funcapp = azurerm_linux_function_app.powershell1.id,
    ecc-azure-454-11_last_powershell_funcapp = azurerm_linux_function_app.powershell1.id,
    ecc-azure-454-51_last_powershell_funcapp = azurerm_linux_function_app.powershell1.id,
    #dotnet
    ecc-azure-430-dep_dotNet_funcapp = azurerm_linux_function_app.dot1.id,
    ecc-azure-455-11_last_dotNet_funcapp = azurerm_linux_function_app.dot1.id,
    ecc-azure-455-51_last_dotNet_funcapp = azurerm_linux_function_app.dot1.id,
    ecc-azure-506-funcapp_next_for_eol_dotNet = azurerm_linux_function_app.dot2.id
  }
}