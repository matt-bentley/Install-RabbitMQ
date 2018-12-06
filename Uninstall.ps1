$ErrorActionPreference = "Stop"

Write-Host "Uninstalling RabbitMQ..."
.\RabbitMQ\Uninstall-Rabbit.ps1

Write-Host "Uninstalling Erlang..."
.\Erlang\Uninstall-Erlang.ps1

Write-Host "Finished uninstall"