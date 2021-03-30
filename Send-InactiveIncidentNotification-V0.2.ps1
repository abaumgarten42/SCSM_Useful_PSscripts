Import-Module SMlets

# Configure Last Modified Days Before
$ModifiedBefore = 3

#Configure Incident Status
$IncidentStatus = 'Active'

# Configure your mail server, the recipient and the sender of the mail  
# $smtphost=�mailserver.yourdomain.local�   
# $from=�mail@yourdomain.local�  
 
$smtphost = "Mailserver.demo.local"    
$from = "Helpdesk@demo.local" 

# Send-Mail function  
function Send-Mail  
    {  
        Param($From,$To,$Subject,$Body)  
        $smtp = new-object system.net.mail.smtpClient($smtphost)  
        $mail = new-object System.Net.Mail.MailMessage  
        $mail.from= $From  
        $mail.to.add($To)  
        $mail.subject= $Subject  
        $mail.body= $Body  
        $mail.isbodyhtml=$true  
        $smtp.send($Mail)  
    } 

# Some other variables     
$BeforeDate = (Get-Date).AddDays(-$ModifiedBefore).ToString("MM/dd/yyy HH:mm:ss")
$Status = Get-SCSMEnumeration IncidentStatusEnum.$IncidentStatus$ 
$AssignedUserObjectRelClass = Get-SCSMRelationshipClass System.WorkItemAssignedToUser
$IncidentClass = Get-SCSMClass -name System.WorkItem.Incident$
 
#Get all incidents last modfied xy days before 
$Incidents= @(Get-SCSMObject -Class $IncidentClass | Where-Object {($_.Status -eq $Status -AND $_.LastModified -lt $BeforeDate)})  

If ($Incidents.count -gt 0) 
{ 
 
#Get all assigned incidents from list 
foreach ($Incident in $Incidents) 
    { 
	# Get AssignedToUser
    $AssignedUser = Get-SCSMRelatedObject -SMObject $Incident -Relationship $AssignedUserObjectRelClass  
 
        # Incidents AssignedTo is not NULL 
		If ($AssignedUser.Displayname) 
            { 
			#Get email adress of AssignedToUser
			$EndPoint = Get-SCSMRelatedObject -SMObject $assignedUser -Relationship $UserPref | Where-Object {$_.ChannelName -like '*SMTP'}
			$Sendto = $Endpoint.Targetaddress 
             
            #Create Output
			$Output = 'This Incident has been inactive for ' + $ModifiedBefore + ' day(s): <br>' + $Incident.ID + ' - ' + $Incident.Title + ' - Last Modified: ' + $Incident.Lastmodified 
			$Output
			#Send email
			$To = $Sendto
			$Subject = 'Inactive incident for ' + $ModifiedBefore + ' day(s): ' + $Incident.Id + ' ' + $Incident.Title
			$Body = $Output 
			Send-Mail $From $to $Subject $Body  
			} 
    } 
}	
 
Remove-Module SMlets -force