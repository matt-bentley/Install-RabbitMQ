$rabbitPath = "C:\Program Files\RabbitMQ"
$Sbin = "C:\Program Files\RabbitMQ\sbin"

$adminPassword = Read-Host -assecurestring -Prompt 'Please enter your strong Administrator password'
$adminPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($adminPassword))

$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

#
# Check if RabbitMQ is installed
#
if(Test-Path -Path $rabbitPath){
	Write-Host "RabbitMQ is already installed."
}
else{
	Write-Host "RabbitMQ not currently installed. Installing..."
	Copy-Item -Path "$scriptDir\RabbitMQ" -Filter "*" -Recurse -Destination "C:\Program Files" -Container
	& $Sbin\rabbitmq-plugins.bat enable rabbitmq_management
	& $Sbin\rabbitmq-service.bat install
	& $Sbin\rabbitmq-service.bat start

	#Add users and passwords. This admin account has access to everything...
	& $Sbin\rabbitmqctl.bat add_user administrator $adminPassword
	& $Sbin\rabbitmqctl.bat set_permissions administrator ".*" ".*" ".*"
	& $Sbin\rabbitmqctl.bat set_user_tags administrator administrator

	#Example adding my self with access to all queues, and as an administrator
	& $Sbin\rabbitmqctl.bat add_user dcadmin "SUPERSECUREPASSWORD!"
	& $Sbin\rabbitmqctl.bat set_permissions matth ".*" ".*" ".*"
	& $Sbin\rabbitmqctl.bat set_user_tags dcadmin administrator

	#The permissions section is a regex for what queues you have access to, CONFIGURE, WRITE, READ.  I have .* (regex for EVERYTHING!) for each, meaning I can config, write, and read anything
	#https://www.rabbitmq.com/access-control.html
	#https://www.rabbitmq.com/man/rabbitmqctl.1.man.html#Access%20control

	#Delete the guest account, it has full admin
	& $Sbin\rabbitmqctl.bat delete_user guest
}