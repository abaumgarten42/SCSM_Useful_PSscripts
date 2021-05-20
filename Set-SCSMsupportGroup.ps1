# Set Support Group based on Incident Classification and Incident Description content

Import-Module SMlets
$smDefaultComputer = "SCSM1"
$irID = "IR2046"

$supportGroup1 = "AppSupport-1"
$supportGroup2 = "AppSupport-2"
$irClassification = "Application1"

$classIncident = Get-SCSMClass -Name System.WorkItem.Incident$

$irObj = Get-SCSMObject -Class $classIncident -Filter "ID -eq $irID"
$irDescription = $irObj.Description
$irObjClassification = $irObj.Classification.DisplayName

if ($irObjClassification -eq $irClassification) {
    if ($irDescription -match "Are you seeing an error message when opening Application1: Yes") {
        Set-SCSMObject -SMObject $irObj -Property "TierQueue" -Value $supportGroup2
        $result = "IR is classification $irClassification and SupportGroup $supportGroup2"
    }
    else {
        if ($irDescription -match "Do you need a file unlocked: Yes") {
            $newSupportGroup = "$enumSupportGroup1"
            Set-SCSMObject -SMObject $irObj -Property TierQueue -Value $supportGroup1
            $result = "IR is classification $irClassification and SupportGroup $supportGroup1"
        }
        else {
            $result = "IR is classification $irClassification but no condition met" 
        }
    }
}
else {
    $result = "IR is not classification $irClassification"
}
$result