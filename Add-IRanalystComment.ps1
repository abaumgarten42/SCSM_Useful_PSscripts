$irId = "IR2046"
$commentText = "Test - Adding an Analyst Comment"
$commentAddedBy = "Andreas Baumgarten" # Could be any name - it's not required the user exists in SCSM
$isPrivateComment = $true # $true or $false
   
$smdefaultserver = "SCSM1"
$incidentClass = Get-SCSMClass -Name System.workitem.Incident$

$irObj = Get-SCSMObject -Class $incidentClass -filter "ID -eq $irId"

$newGUID = ([guid]::NewGuid()).ToString()
$projection = @{__CLASS = "System.WorkItem.TroubleTicket";
    __SEED              = $irObj;
    AnalystComments     = @{__CLASS = "System.WorkItem.TroubleTicket.AnalystCommentLog";
        __OBJECT                = @{id = $NewGUID;
            DisplayName = $newGUID;
            Comment     = $commentText;
            EnteredBy   = $commentAddedBy;
            EnteredDate = (Get-Date).ToUniversalTime();
            IsPrivate   = $isPrivateComment 
        }
    }
}
New-SCSMObjectProjection -Type "System.WorkItem.IncidentPortalProjection" -Projection $projection