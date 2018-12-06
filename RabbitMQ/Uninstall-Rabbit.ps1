$rabbitPath = "C:\Program Files\RabbitMQ"

#
# Check if RabbitMQ is installed
#
if(Test-Path -Path $rabbitPath){
	& 'C:\Program Files\RabbitMQ\sbin\rabbitmq-service.bat' stop
	& 'C:\Program Files\RabbitMQ\sbin\rabbitmq-service.bat' remove
	Remove-Item $rabbitPath -Force -Recurse
}
else{
	Write-Host "RabbitMQ is not installed"
}