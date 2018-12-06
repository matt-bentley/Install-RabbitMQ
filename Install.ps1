$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

Write-Host "Installing Erlang..."
& $scriptDir\Erlang\Install-Erlang.ps1
Write-Host "Finished installing Erlang."

# update environment variables for session
foreach($level in "Machine","User") {
    [Environment]::GetEnvironmentVariables($level).GetEnumerator() | % {
       # For Path variables, append the new values, if they're not already in there
       if($_.Name -match 'Path$') { 
          $_.Value = ($((Get-Content "Env:$($_.Name)") + ";$($_.Value)") -split ';' | Select -unique) -join ';'
       }
       $_
    } | Set-Content -Path { "Env:$($_.Name)" }
 }

Write-Host "Installing RabbitMQ..."
& $scriptDir\RabbitMQ\Install-Rabbit.ps1

Write-Host "Install complete"