$erlangPath = "HKLM:\SOFTWARE\Wow6432Node\Ericsson\Erlang"

$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

#
# Check if Erlang is installed
#
$erlangkey = Get-ChildItem $erlangPath -ErrorAction SilentlyContinue
if ( $erlangkey -eq $null ) { 
	Write-Host "Erlang not currently installed. Installing..."
	Start-Process -Wait "$scriptDir\otp_win64_21.1.exe" /S
}
else {
	Write-Host "Erlang already installed."
}

#
# Determine Erlang home path
#
$ERLANG_HOME = ((Get-ChildItem $erlangPath)[0] | Get-ItemProperty).'(default)'
[System.Environment]::SetEnvironmentVariable("ERLANG_HOME", $ERLANG_HOME, "Machine")

#
# Add Erlang to the path if needed
#
$system_path_elems = [System.Environment]::GetEnvironmentVariable("PATH", "Machine").Split(";")
if (!$system_path_elems.Contains("%ERLANG_HOME%\bin") -and !$system_path_elems.Contains("$ERLANG_HOME\bin")) 
{
	Write-Host "Adding erlang to path"
    $newpath = [System.String]::Join(";", $system_path_elems + "$ERLANG_HOME\bin")
    [System.Environment]::SetEnvironmentVariable("PATH", $newpath, "Machine")
}