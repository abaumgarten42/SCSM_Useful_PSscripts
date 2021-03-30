# Author: Anton Gritsenko - freemanru[at]gmail[dot]com
# Posted the script here withe the permission of Anton
# Code below is using the same aproach as it do a SCSM AD Connector


#for domain ("Use the domain" option in AD connector)
$domainName = "syscenter.local"
$de = new-object System.DirectoryServices.DirectoryEntry("LDAP://" + $domainName+"/RootDSE")

write-host ("DC: " + $de.Properties["dnsHostName"].Value.ToString())


#for DN ("Let me choose the domain or OU" option in AD connector)
$rootPath = "LDAP://OU=Domain Controllers,DC=syscenter,DC=local"
[StringComparer]$test = [System.StringComparer]::OrdinalIgnoreCase

$index = $rootPath.IndexOf("DC=")
if ($index -gt 0)
{
    $rootPath = $rootPath.Substring($index)
    $rootPath = [Regex]::Replace([Regex]::Replace($rootPath, "DC=", "", "IgnoreCase"), ",", ".");
}

$de = new-object System.DirectoryServices.DirectoryEntry("LDAP://" + $rootPath+"/RootDSE")
write-host ("DC: " + $de.Properties["dnsHostName"].Value.ToString())