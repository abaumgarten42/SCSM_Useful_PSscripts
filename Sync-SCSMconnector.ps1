# Import-Module
Import-Module SMLets
# Get Connector Object
$MyConn = Get-SCSMConnector  | Where-Object {$_.DisplayName -eq ‘AD Connector’}
# Start Connector
Start-SCSMConnector -Connector $MyConn