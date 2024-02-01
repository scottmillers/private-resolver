[CmdletBinding()]

param 
( 
    [Parameter(ValuefromPipeline=$true,Mandatory=$true)] [string]$Domain_DNSName
)

#


# Replace with your desired static IP address, subnet mask, and default gateway, and dns server
$InterfaceAlias = "Ethernet"  # Change this to the name of your network interface
$IPAddress = '10.0.2.10'
$SubnetMask = '255.255.255.0'
$DefaultGateway = '10.0.2.1'
$DnsServerIpAddress = "10.0.2.10"  


# Set the static IP address, default gateway, and DNS server
Set-NetIPAddress -InterfaceAlias $InterfaceAlias -IPAddress $IPAddress -PrefixLength 24 
Set-NetRoute -InterfaceAlias $InterfaceAlias  -DestinationPrefix "0.0.0.0/0" -NextHop $DefaultGateway -RouteMetric 10
Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $DnsServerIpAddress


# Install DNS Server
Install-WindowsFeature -Name DNS -IncludeManagementTools

# Create a forward lookup zone
#$ZoneNameFwd = "onpremise.hhs.gov"
$ZoneNameFwd = $Domain_DNSName
$ZoneFile = "$ZoneNameFwd.dns"
Add-DnsServerPrimaryZone -Name $ZoneNameFwd -ZoneFile $ZoneFile

# Create a reverse lookup zone
$ZoneNameRev = "2.0.10.in-addr.arpa"
$ZoneFile = "$ZoneNameRev.dns"
Add-DnsServerPrimaryZone -ZoneName $ZoneNameRev -ZoneFile $ZoneFile

# Create a conditional forwarder
Add-DnsServerConditionalForwarderZone -Name "bep.hhs.gov" -MasterServers 10.0.0.4 -PassThru


# Create the host records for the DNS server
Add-DnsServerResourceRecordA -ZoneName $ZoneNameFwd -Name "dns" -IPv4Address "10.0.2.10"
Add-DnsServerResourceRecordPtr -ZoneName $ZoneNameRev -Name "10" -PtrDomainName "dns.$ZoneNameFwd"

# Create a host record for a host
Add-DnsServerResourceRecordA -ZoneName $ZoneNameFwd -Name "vmone" -IPv4Address "10.0.2.14"
Add-DnsServerResourceRecordPtr -ZoneName $ZoneNameRev -Name "14" -PtrDomainName "vmone.$ZoneNameFwd"

