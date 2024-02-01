[CmdletBinding()]

param 
( 
    [Parameter(ValuefromPipeline=$true,Mandatory=$true)] [string]$ssh_public_key
)

Process {
# Install OpenSSH Server
Install-WindowsFeature -Name OpenSSH.Server -IncludeManagementTools
#Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value $SSH_PublicKey ;icacls.exe ""$env:ProgramData\ssh\administrators_authorized_keys"" /inheritance:r /grant ""Administrators:F"" /grant ""SYSTEM:F"""
}