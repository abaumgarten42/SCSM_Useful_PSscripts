# Get analyst comment, user comment and action log entries from Incident Record

Import-module SMlets # Implort SMLets module
$smdefaultserver = "SCSM1" # Define SCSM Management Server
$IRid = "IR2031" # Define Incident Record
$IRclass=Get-SCSMclass -name System.Workitem.Incident$ # Get SCSM Incident class object
$IRobject=Get-SCSMobject -class $IRclass -filter "ID -eq $IRid" # Get IR object

# Get analys comments of Incident
$relIncidentAnalystComment = Get-SCSMRelationshipClass -Name System.WorkItem.TroubleTicketHasAnalystComment$
$AnalystComments = Get-SCSMRelatedObject -SMObject $IRobject -Relationship $relIncidentAnalystComment
$AnalystComments | Select *

# Get user comment of Incident
$relIncidentUserComment = Get-SCSMRelationshipClass -Name System.WorkItem.TroubleTicketHasUserComment$
$UserComments = Get-SCSMRelatedObject -SMObject $IRobject -Relationship $relIncidentUserComment
$UserComments | Select *

# Get action log entries of Incident
$relIncidentActionLog = Get-SCSMRelationshipClass -Name System.WorkItem.TroubleTicketHasActionLogg$
$ActionLogEntries = Get-SCSMRelatedObject -SMObject $IRobject -Relationship $relIncidentActionLog
$ActionLogEntries | Select *