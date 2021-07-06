# Create an Incident with different properties and Affected User

Import-Module SMlets # Import SMLets module
$smdefaultserver = "SCSM1" # Define SCSM Management Server
# Define Incicent properties
$irTitle = "Test Incident by PowerShell 1"
$irDescription = "Test Description"
$irUrgency = "Medium"
$irImpact = "Medium"
$irSource = "System"
$irClassification = "Other Problems"
$irStatus = "Active"
$irTierQueue = "Tier1"
$irAffectedUser = "ppan1234"
# --------------------
$IRclass = Get-SCSMclass -name System.Workitem.Incident$ # Get SCSM Incident class object
$UserClass = Get-SCSMClass -name System.Domain.User$ # Get SCSM User class class object
$relAffectedUser = Get-SCSMRelationshipClass -Name System.WorkItemAffectedUser # Get SCSM relationship Affected User
#  Get Affected User  
$irAffectedUserObj = Get-SCSMObject -Class $UserClass -Filter "UserName -eq $irAffectedUser"
# Prepare Incident properties
$properties = @{
    Id             = "IR{0}"
    Title          = $irTitle
    Description    = $irDescription
    Urgency        = $irUrgency
    Impact         = $irImpact
    Source         = $irSource
    Status         = $irStatus
    Classification = $irClassification
    TierQueue      = $irTierQueue
}
# Create Incident object
$newIR = New-SCSMObject -Class $IRclass -PropertyHashtable $properties -PassThru
# Set Affected User
if ($irAffectedUserObj -and $newIR) {
    New-SCSMRelationshipObject -RelationShip $relAffectedUser -Source $newIR -Target $irAffectedUserObj -Bulk
}
