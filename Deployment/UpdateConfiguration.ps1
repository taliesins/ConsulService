[CmdletBinding()]
param(
	[string] $environmentConfigurationFilePath = (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) "deployment_configuration.json" ),
	[string] $productConfigurationFilePath = (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) "configuration.xml" )
)

$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
Import-Module $scriptPath\PowershellModules\CommonDeploy.psm1 -Force

$rootPath = Split-Path -parent $scriptPath

$e = $environmentConfiguration = Read-ConfigurationTokens $environmentConfigurationFilePath
$p = $productConfiguration = Get-Configuration $environmentConfigurationFilePath $productConfigurationFilePath

$confileFilePath = "$rootPath\config\config.json"

$config = @"
{
    "bootstrap": true,
    "server": true,
    "datacenter": "RG",
    "data_dir": "..\\..\\consul-data\\",
    "ui_dir": "..\\ui\\",
    "encrypt": "U+ff6ZZlI7Zm4w2oHWVCSg==",
    "log_level": "Trace"
}
"@

Set-Content -Path $confileFilePath -Value $config