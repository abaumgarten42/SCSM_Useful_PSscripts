Import-module SMlets # Import SMLets module
$smdefaultserver = "SCSM1" # Define SCSM Management Server
$IRid = "IR2031" # Define Incident Record
$IRclass=Get-SCSMclass -name System.Workitem.Incident$ # Get SCSM Incident class object
$IRobject=Get-SCSMobject -class $IRclass -filter "ID -eq $IRid" # Get IR object
$IRobject | format-list # show all properties and values of the IR object

# Set dedicated variables with IR properties
$Title = $IRobject.Title
$Description = $IRobject.Description
$Status = $IRobject.Status
$Impact = $IRobject.Impact
$Urgency = $IRobject.Urgency
$Id = $IRobject.Id
$CreatedDate = $IRobject.CreatedDate
$LastModifiedDate = $IRobject.LastModified
$Classification = $IRobject.Classification.DisplayName
$SupportGroup = $IRobject.TierQueue.DisplayName

# Get related objects of Incident objects
# Get relationships
$relAffectedUser = Get-SCSMRelationshipClass -Name System.WorkItemAffectedUser
$relAssignToUser = Get-SCSMRelationshipClass -Name System.WorkItemAssignedToUser
$relAffectedConfigItems = Get-SCSMRelationshipClass -Name System.WorkItemAboutConfigItem
# Get related object - Affected User
$affectedUserDisplayName = (Get-SCSMRelatedobject -SMObject $IRobject -Relationship $relAffectedUser).DisplayName
$affectedUserUserName = (Get-SCSMRelatedobject -SMObject $IRobject -Relationship $relAffectedUser).UserName
# Get related object - Assigned To User
$assignedToUserDisplayName = (Get-SCSMRelatedobject -SMObject $IRobject -Relationship $relAssignToUser).DisplayName
$assignedToUserUserName = (Get-SCSMRelatedobject -SMObject $IRobject -Relationship $relAssignToUser).UserName
# Get affected Config Items
$affectedConfigItemsDisplayName = (Get-SCSMRelatedobject -SMObject $IRobject -Relationship $relAffectedConfigItems).DisplayName
