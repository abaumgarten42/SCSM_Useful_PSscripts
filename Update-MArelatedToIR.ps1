Import-Module SMlets
$smdefaultserver = "SCSM1"
# Define Manual Activity properties
$irID = "IR2103"
$maTitle = "Update Test MA by PowerShell32"
$maDescription = "Update Test Description 32"
$maPriority = "Medium"
$maArea = "Other"
$maStatus = "In Progress"
$maAssignedToUser = "ppan1234"
$maNotes = "Update Note 32"
$maScheduledStartDate = "07/29/2021 13:00" # UTC time
$maScheduledEndDate = " 07/30/2021 11:00"  # UTC time
######
$relAssignedToUser = Get-SCSMRelationshipClass -Name System.WorkItemAssignedToUser
$relWIcontainsActivity = Get-SCSMRelationshipClass -Name System.WorkItemContainsActivity
$irClass = Get-SCSMclass -name System.Workitem.Incident$
$maClass = Get-SCSMclass -name System.Workitem.Activity.ManualActivity$
$UserClass = Get-SCSMClass -name System.Domain.User$
# Get SCSM objects
$irObj = Get-SCSMObject -Class $irClass -Filter "ID -eq $irID"
$maObj = Get-SCSMRelatedObject -SMObject $irObj -Relationship $relWIcontainsActivity
$maAssignedToUserObj = Get-SCSMObject -Class $UserClass -Filter "UserName -eq $maAssignedToUser"
# Update properties
if ($maTitle -and $maObj) {
    $maObj | Set-SCSMObject -Property Title -Value $maTitle
}
if ($maDescription -and $maObj) {
    $maObj | Set-SCSMObject -Property Description -Value $maDescription
}
if ($maPriority -and $maObj) {
    $maObj | Set-SCSMObject -Property Priority -Value $maPriority
}
if ($maArea -and $maObj) {
    $maObj | Set-SCSMObject -Property Area -Value $maArea
}
if ($maStatus -and $maObj) {
    $maObj | Set-SCSMObject -Property Status -Value $maStatus
}
if ($maNotes -and $maObj) {
    $maObj | Set-SCSMObject -Property Notes -Value $maNotes
}
if ($maScheduledStartDate -and $maObj) {
    $maObj | Set-SCSMObject -Property ScheduledStartDate -Value $maScheduledStartDate
}
if ($maScheduledEndDate -and $maObj) {
    $maObj | Set-SCSMObject -Property ScheduledEndDate -Value $maScheduledEndDate
}
if ($maAssignedToUserObj -and $maObj) {
    New-SCSMRelationshipObject -RelationShip $relAssignedToUser -Source $maObj -Target $maAssignedToUserObj -Bulk
}

