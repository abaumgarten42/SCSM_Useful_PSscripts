# Import SMlets module 
Import-Module SMlets -Force

# Incident ID
$ID = "IR189"

# User SAM Account Name current session
$Username = (Get-Item env:Username).Value

# Get Incident class
$IncidentClass = Get-SCSMClass -name System.WorkItem.Incident$
# Get User class
$UserClass = Get-SCSMClass -name System.Domain.User$
# Get relationship class "Incident has Assigned to User"
$AssignedToUserRelClass  = Get-SCSMRelationshipClass -Name System.WorkItemAssignedToUser$
# Get relationship class "Incident has Primary Owner"
$IncidentPrimaryOwnerRelClass = Get-SCSMRelationshipClass -Name System.WorkItem.IncidentPrimaryOwner$

# Get Incident
$Incident = Get-SCSMObject -Class $IncidentClass -Filter "ID -eq $ID"

# Get User Object
$User = Get-SCSMObject -Class $UserClass -Filter "Username -eq $Username"

#Set new Primary Owner of the Incident 
New-SCSMRelationshipObject -RelationShip $IncidentPrimaryOwnerRelClass -Source $Incident -Target $User -Bulk 

# Set new assigend to user of the Incident = user who resolved the Incident 
New-SCSMRelationshipObject -RelationShip $AssignedToUserRelClass -Source $Incident -Target $User -Bulk 

#Remove SMlets module
Remove-Module SMlets