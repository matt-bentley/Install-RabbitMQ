$erlangPath = "HKLM:\SOFTWARE\Wow6432Node\Ericsson\Erlang"
$erlangUninstall = "C:\Program Files\erl9.3\Uninstall.exe"

#
# Check if Erlang is installed
#
$erlangkey = Get-ChildItem $erlangPath -ErrorAction SilentlyContinue
if ( $erlangkey -eq $null ) { 
	Write-Host "Erlang is not installed."
}
else {
	Start-Process -Wait $erlangUninstall /S
	Write-Host "Finished uninstalling Erlang."
}
