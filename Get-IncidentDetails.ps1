Import-module SMlets # Implort SMLets module
$smdefaultserver = "SCSM1" # Define SCSM Management Server
$IRid = "IR2031" # Define Incident Record
$IRclass=Get-SCSMclass -name System.Workitem.Incident$ # Get SCSM Incident class object
$IRobject=Get-SCSMobject -class $IRclass -filter "ID -eq $IRid" # Get IR object
$IRobject | fl # show all properties and values of the IR object

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
