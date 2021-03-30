# Import SMlets module 
Import-Module SMlets -force
 
# Configure your mail server, the recipient and the sender of the mail 
# $smtphost="mailserver.yourdomain.local" 
# $to="administrator@yourdomain.local" 
# $from="mail@yourdomain.local" 

$smtphost = "mailserver.demo.local" 
$to = "Administrator@demo.local" 
$from = "Helpdesk@demo.local" 

# Configure time value Incident is created before xy minutes  
$CreatedBefore = 120
#Configure Support GroupTier Queue Friendly Name (Displayname)
$DisplayNSupportGrp = 'Tier 1'

# Send-Mail function 
function Send-Mail 
	{ 
		param($From,$To,$Subject,$Body) 
		$smtp = new-object system.net.mail.smtpClient($smtphost) 
		$mail = new-object System.Net.Mail.MailMessage 
		$mail.from= $From 
		$mail.to.add($To) 
		$mail.subject= $Subject 
		$mail.body= $Body 
		$mail.isbodyhtml=$true 
		$smtp.send($mail) 
	}
	
# Some other variables	
$TierQueue = Get-SCSMEnumeration | Where-Object {$_.DisplayName -eq $DisplayNSupportGrp}
$BeforeDate = (get-date).AddMinutes(-$CreatedBefore).ToString("MM/dd/yyy HH:mm:ss")
$Active = Get-SCSMEnumeration IncidentStatusEnum.Active$
$TierDisplayname = $TierQueue.Displayname
$TierDisplayname
$AssignedUserObjectRelClass = Get-SCSMRelationshipClass System.WorkItemAssignedToUser
$IncidentClass = Get-SCSMClass -Name System.WorkItem.Incident$
$Output = 'ID - Title <br>'
$Counter = 0

#Get all acitiv incidents from a tier Queue created xy minutes before
$Incidents = @(Get-SCSMObject -Class $IncidentClass | Where-Object {($_.Status -eq $Active -AND $_.TierQueue -eq $TierQueue -AND ($_.CreatedDate) -lt $BeforeDate)})

$Incidents.count

If ($Incidents.count -gt 0)
	{
	#Get all unassigned incidents from list
	foreach ($Incident in $Incidents)
		{
		$AssignedUser = Get-SCSMRelatedObject -SMObject $Incident -Relationship $AssignedUserObjectRelClass 

			If (!$AssignedUser.Displayname)
				{
					$AssignedUser
					$Counter = $Counter + 1
					$Output = $Output + "`r`n`r`n" + $Incident.ID + ' - ' + $Incident.Title + ' <br>'
				}
		}

	$Output
	
	# If there is any unassigned incident send a mail with a list of these incidents 
	if ($Counter -gt 0) 
		{ $subject = "Unassigned incidents in Service Manager Support Group: "+ $TierQueue.Displayname + ", total of " + $Counter
		$body = $Output
	Send-Mail $from $to $subject $body 
		}
	}	
Remove-Module SMlets -force