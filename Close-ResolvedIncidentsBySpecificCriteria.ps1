import-module smlets -force

# Define Resolved By Users - Incidents created or resoved by these users are processed
$User1 = "Administrator"
$User2 = "Alt"
$User3 = "PeterPan"
#
# Set Target Support Group (Displayname) - This Support Group will be set if no Support Group is set in the Incident
$DisplayNSupportGrp = 'Undefined Queue' 
#
########### The magic starts here ###########
#
# Get Incident status Resolved 
$Resolved = Get-SCSMEnumeration IncidentStatusEnum.Resolved$
# Get Incident status Closed
$Closed = Get-SCSMEnumeration IncidentStatusEnum.Closed$
# Get Target Support Queue
$TargetTierQueue = Get-SCSMEnumeration | Where-Object {$_.DisplayName -eq $DisplayNSupportGrp}
# Get Incident class
$IncidentClass = Get-SCSMClass -Name System.WorkItem.Incident$
# Get Relationship Incident - ResolvedBy
$ResolvedByUserObjectRelClass = Get-SCSMRelationshipClass System.WorkItem.TroubleTicketResolvedByUser 
# Get Relationship Incident - CreatedBy
$CreatedByUserObjectRelClass = Get-SCSMRelationshipClass System.WorkItemCreatedByUser 
# Set variable = $NULL
$IncidentToClose = $NULL
# Prepare PropertyHash
$Propertyhash = @{"Status" = $Closed ; "Tierqueue" = $TargetTierQueue}
# Get all incidents with status = "resolved" + Tier Queue = "empty"
$Incidents = @(Get-SCSMObject -Class $IncidentClass | Where-Object {$_.Status -eq $Resolved -AND $_.Tierqueue -eq $NULL})
# If Incidents found
If ($Incidents.count -gt 0) 
	{ 
	# Do the following commands for each Incident
	foreach ($Incident in $Incidents)
		{
		# Get CreatedBy User of Incident
		$CreatedByUser = Get-SCSMRelatedObject -SMObject $Incident -Relationship $CreatedByUserObjectRelClass
		#$CreatedByUser
		#Output Incident Id and CreatedByUser (just for a short check)
		Write-Host $Incident.Id "created by" "" -NoNewline; Write-Host $CreatedByUser.Displayname
		#Get ResolvedBy User of Incident
		$ResolvedByUser = Get-SCSMRelatedObject -SMObject $Incident -Relationship $ResolvedByUserObjectRelClass
		#Output Incident Id and ResolvedByUser (just for a short check)
		Write-Host $Incident.Id "resolved by" "" -NoNewline; Write-Host $ResolvedByUser.DisplayName
		# Check if the user is one of the defined users
		If ($CreatedByUser.Displayname -eq $User1 -OR $CreatedByUser.Displayname -eq $User2 -OR $CreatedByUser.Displayname -eq $User3 -OR $ResolvedByUser.Displayname -eq $User1 -OR $ResolvedByUser.Displayname -eq $User2 -OR $ResolvedByUser.Displayname -eq $User3)
				{
				# Prepare Output of Incidents that will be closed
				$IncidentToClose = $IncidentToClose + " " + $Incident.Id
				# Output of Incidents that will be closed by this script (just for a short check)
				Write-Host "This Incident(s) will be closed:" $IncidentToClose
				# Preparation for closing
				$CloseIncident = $Incident
				# Close Incidents -> That's the dangerous part if something is wrong in the script ;-)
				$CloseIncident |Set-SCSMObject -PropertyHashtable $Propertyhash
				}
		}
	}
	Else {Write-Host "No Incident met the criteria"}
