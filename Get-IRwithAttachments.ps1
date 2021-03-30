Import-Module smlets

# Get Incident Class
$IncidentClass = Get-SCSMClass -Name System.WorkItem.Incident$                                             

# Get Relationship WorkItem Has File Attachment
$WIhasFileAttachment = Get-SCSMRelationshipClass System.WorkItemHasFileAttachment

# Clear Variable Output
$Output = ''

# Get all Incidents
$Incidents = Get-SCSMObject -Class $IncidentClass

# For each Incident found
foreach ($Incident in $Incidents)
 {
 # Get related FileAttachment
 $FileAttachment = Get-SCSMRelatedObject -SMObject $Incident -Relationship $WIhasFileAttachment 
 	# If FileAttachment exists
 	If ($FileAttachment.Displayname)
		{
		# Create list of Incidents with FileAttachment
		$Output = $Output + "`r`n`r`n" + $Incident.ID + ' - ' + $Incident.Title
		}
 }
# Output 
$Output

Remove-Module smlets