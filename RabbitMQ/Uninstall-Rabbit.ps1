$rabbitPath = "C:\Program Files\RabbitMQ Server"
$Sbin = "$rabbitPath\rabbitmq_server-3.7.5\sbin"

#
# Check if RabbitMQ is installed
#
if(Test-Path -Path $rabbitPath){
	& $Sbin\rabbitmq-service.bat stop
	& $Sbin\rabbitmq-service.bat remove
	Start-Process -Wait "$rabbitPath\uninstall.exe" /S
}
else{
	Write-Host "RabbitMQ is not installed"
}