Import-Module SMlets -Force

# Define Change Request
$CR="CR1698"

# Get Change Request Class
$CRclass = Get-SCSMClass -Name System.WorkItem.ChangeRequest$ 

# Get object relationship 
$CRMAObjectRelClass = Get-SCSMRelationshipClass System.WorkItemContainsActivity

# Get CR Object
$CRobject = Get-SCSMObject -Class $CRclass -Filter "ID -eq $CR"
$CRobject

# Get related MA objects
$MAobjects =  @(Get-SCSMRelatedObject -SMObject $CRobject -Relationship $CRMAObjectRelClass | Where-Object {($_.Classname -eq "System.WorkItem.Activity.ManualActivity")})
$MAobjects

# Set property values
$Propertyhash = @{"ScheduledStartDate" = $CRobject.ScheduledStartDate; "ScheduledEndDate" = $CRobject.ScheduledEndDate}

# Set property values for each MA related to CR
 foreach ($MA in $MAobjects)
	{
	 $MA | Set-SCSMObject -PropertyHashtable $Propertyhash 
	}

Remove-Module SMlets -Force