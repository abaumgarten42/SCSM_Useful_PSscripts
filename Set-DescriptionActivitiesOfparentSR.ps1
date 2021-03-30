# Import SMlets module
Import-Module smlets -force 2>&1

#------ Variables ------

# ID of the Service Request
$id = "SR32047"

# Name of the SCSM Management Server
$smDefaultComputer = "scsm1"

# Classes, relationships and more stuff
$srClass = Get-SCSMClass -Name System.WorkItem.ServiceRequest$
$aClass = Get-SCSMClass -Name System.WorkItem.Activity$
$relWIcontainsActivity =  Get-SCSMRelationshipClass -Name System.WorkItemContainsActivity$
$relWIrelatesToWI =  Get-SCSMRelationshipClass -Name System.WorkItemRelatesToWorkItem$

# Get Parent Service Request and Description
$pSRobj = Get-SCSMObject -Class $srClass -Filter "Id = $id"
$pSRdescription = $pSRobj.Description

$PropertyHash = @{"Description" = $pSRdescription}

# Get all related Activities of Parent Service Request and set Description
$pSRactivities = Get-SCSMRelatedObject -SMObject $pSRobj -Relationship $relWIcontainsActivity -Depth Recursive
$pSRactivities | Set-SCSMObject -PropertyHashtable $PropertyHash

