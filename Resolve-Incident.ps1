Import-Module SMLets
# Set some variables
$irId="IR2046" # Incident ID
$resolvedByUserName = "ppan1234" # Resolved By UserName
# Resolution details
$resolutionDescription = "Just a test" # Resolution Description
$resolutionCategory = "Fixed By Analyst" # Resolution Category

# Get required SCSM classes
$irClass = Get-SCSMClass -Name System.workitem.Incident$
$userClass = Get-SCSMclass -Name System.Domain.User$
# Get relationship class
$resolvedByUserRel = Get-SCSMRelationshipClass -name System.WorkItem.TroubleTicketResolvedByUser$
# Get required SCSM objects
# Incident object
$irObj = Get-SCSMObject -Class $irClass -Filter "ID -eq $irId"
# ResolvedBy User object
$resolvedByUserObj = Get-SCSMObject -Class $userClass -Filter "UserName -eq $resolvedByUserName"

# Prepar resolution details 
$resolveDetails=@{
"Status" = "Resolved";
"ResolutionDescription" = "$resolutionDescription";
"ResolutionCategory" = "$resolutionCategory";
"ResolvedDate" = (Get-Date).ToUniversalTime();
"TargetResolutionTime" = (Get-Date).ToUniversalTime();
}
# Update incident object with resolution details
Set-SCSMObject -SMObject $irObj -PropertyHashtable $resolveDetails

# Create new relationship object ResolvedByUser
New-SCSMRelationshipObject -Relationship $resolvedByUserRel -Source $irObj -Target $resolvedByUserObj -Bulk