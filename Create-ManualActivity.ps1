# Create a Manual Activiy with different properties and AssignedTo User

Import-Module SMlets # Import SMLets module
$smdefaultserver = "SCSM1" # Define SCSM Management Server
# Define Manual Activity properties
$maTitle = "Test MA by PowerShell 1"
$maDescription = "Test Description"
$maPriority = "Medium"
$maArea = "Other"
$maStatus = "In Progress"
$maAssignedToUser = "ppan1234"
# --------------------
$smdefaultserver = "SCSM1" # Define SCSM Management Server
$MAclass = Get-SCSMclass -name System.Workitem.Activity.ManualActivity$ # Get SCSM Manual Activity class object
$UserClass = Get-SCSMClass -name System.Domain.User$ # Get SCSM User class object
$relAssignedToUser = Get-SCSMRelationshipClass -Name System.WorkItemAssignedToUser # Get SCSM relationship AssignedTo User
#  Get AssignedTo User  
$maAssignedToUserObj = Get-SCSMObject -Class $UserClass -Filter "UserName -eq $maAssignedToUser"
# Prepare Manual Activity properties
$properties = @{
    Id          = "MA{0}"
    Title       = $maTitle
    Description = $maDescription
    Priority    = $maPriority
    Area        = $maArea
    Status      = $maStatus
}
# Create Manual Activity object
$newMA = New-SCSMObject -Class $MAclass -PropertyHashtable $properties -PassThru
# Set AssignedTo User
if ($maAssignedToUserObj -and $newMA) {
    New-SCSMRelationshipObject -RelationShip $relAssignedToUser -Source $newMA -Target $maAssignedToUserObj -Bulk
}