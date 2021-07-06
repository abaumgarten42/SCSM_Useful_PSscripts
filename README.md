# SCSM Useful PS Scripts 
Microsoft System Center Service Manager
- Some helpful PowerShell scripts for SCSM
- SMLets are required: https://github.com/SMLets/SMLets   
- *Some scripts were published before in the Microsoft Technet Gallery (retired)*  
- *Should work with SCSM 2012/2012R2/2016/2019*  

-----------------

Scripts in this repository:
- [Create-Incident.ps1](Create-Incident.ps1)
  - Create new Incident with Affected User 
- [Create-ManualActivity.ps1](Create-ManualActivity.ps1)
  - Create new ManualActivity with AssignedTo User 
- [Resolve-Incident.ps1](Resolve-Incident.ps1)
  - Resolve Incident with details and ResolvedByUser 
- [Add-IRanalystComment.ps1](Add-IRanalystComment.ps1)
  - Adds an Analyset Comment to an Incident
- [Set-SCSMsupportGroup.ps1](Set-SCSMsupportGroup.ps1)
  - Set Support Group based on Incident Classification and Incident Description content
- [Get-IncidentComments.ps1](Get-IncidentComments.ps1)
  - Get analyst comment, user comment and action log entries from Incident Record
- [Get-IncidentDetails.ps1](Get-IncidentDetails.ps1)
  - Get Incident Record details in individual variables 
- [Send-InactiveIncidentNotification-V0.2.ps1](Send-InactiveIncidentNotification-V0.2.ps1)
  - Sent email notification if Incident is inactive for x days 
- [Send-UnassignedIncidentsMail-V0.4.ps1](Send-UnassignedIncidentsMail-V0.4.ps1)  
  - Sent email notification if Incident is unassigned for x hours 
- [Set-PrimaryAndAssignedUser.ps1](Set-PrimaryAndAssignedUser.ps1)  
  - Set user -> Incident Assigned User + Primary Owner
- [Set-ScheduledStartEndFromCRtoMA.ps1](Set-ScheduledStartEndFromCRtoMA.ps1)  
  - Set Scheduled StartDate of CR in all related MAs
- [Get-IRwithAttachments.ps1](Get-IRwithAttachments.ps1)  
  - Get incidents with file attachments
- [Generate_Holiday-CSV_for_SLA-Calender.zip](Generate_Holiday-CSV_for_SLA-Calender.zip)
  - From Anders Asp and Andreas Baumgarten
  - Everything you need to create a csv file with the holidays for your SCSM SLA Calendar
  - https://techcommunity.microsoft.com/t5/system-center-blog/scsm-2012-import-holidays-in-sla-calendar/ba-p/344629  
- [Set-DescriptionWithUserInput.ps1](Set-DescriptionWithUserInput.ps1)  
  - Write SR User Input in SR Description field
- [Set-DescriptionActivitiesOfparentSR.ps1](Set-DescriptionActivitiesOfparentSR.ps1)  
  - Write SR Description in all related Activities' Description fields
- [Sync-SCSMconnector.ps1](Sync-SCSMconnector.ps1)
  - Start a SCSM Connector via script
- [Get-DCusedByADconnector.ps1](Get-DCusedByADconnector.ps1)
  - From Anton Gritsenko (got the permission from Anton to put the script in this repository)
  - Get the name of the DC that is used by SCSM AD Connectors
- [Get-SCSMrolesOfUser.ps1](Get-SCSMrolesOfUser.ps1)
  - From Anton Gritsenko (got the permission from Anton to put the script in this repository)
  - Get the user's SCSM role memberships 
- [Close-ResolvedIncidentsBySpecificCriteria.ps1](Close-ResolvedIncidentsBySpecificCriteria.ps1)
  - Close resolved Incidents of different criterias (resolved or created by different users)
  
-----------------

External links for cool SCSM stuff:

- Getting SCSM Object History using PowerShell and SDK
  - From Jan Vidar Elven
  - https://gotoguy.blog/2016/01/27/getting-scsm-object-history-using-powershell-and-sdk/
- Affected User SMTP Address
  - From Patrik Sundqvist
  - http://blogs.litware.se/?p=796
- How to get CIs updated by specified connector with supported way
  - From Anton Gritsenko
  - https://blog.scsmsolutions.com/2013/07/how-to-get-cis-update-by-specified-connector-with-supported-way/
- Free SCSM Tools from Operaio GmbH
  - https://operaio.ch/en/operaio-itsm-software/scsm-free-extensions/
  - Entity Explorer - https://bit.ly/3cymaWJ
  - Clone User Role - https://bit.ly/3fqCj2q
  - MPB Maker - https://bit.ly/31uBhKn
  - Email Template Tester - https://bit.ly/3da38Vu
  - Advanced Console Search - https://bit.ly/31uHLZL
- Free Community Apps for Microsoft Service Manager from Cireson
  - https://cireson.com/products/free-community-apps/
  - Self-Service Portal – Community
  - Auto Close – Community
  - Advanced Send Email – Community
  - Notify Analyst – Community
  - Service Desk Ticker – Community
  - Time Tracker – Community
- Free Products from Xapity
  - https://www.xapity.com/
  - Xapity Attachments (free) - https://www.xapity.com/xapity-attachments
  - Xapity Current Activity (free) - https://www.xapity.com/xapity-current-activity
  - Xapity User History (free) - https://www.xapity.com/xapity-user-history
- SMLets-based SCSM Exchange Connector
  - From AdhicAdam, PeterMiklian, JanSchulz
  - https://github.com/AdhocAdam/smletsexchangeconnector 
- SCSM: Datawarehouse Jobs Failing - Technet WIKI
  - https://social.technet.microsoft.com/wiki/contents/articles/37780.scsm-datawarehouse-jobs-failing.aspx?Sort=MostRecent&PageIndex=1
  - Remove Lock
  - Reset Batch Jobs
  - PowerShell to Rerun Jobs
- SCSM Troubleshooting: MonitoringHost.exe no longer runs and Connectors not working  
  - https://social.technet.microsoft.com/wiki/contents/articles/52200.scsm-troubleshooting-monitoringhost-exe-no-longer-runs-and-connectors-not-working.aspx     

-----------------

Books:

- Microsoft System Center 2016 Service Manager Cookbook - Second Edition
  - https://www.packtpub.com/product/microsoft-system-center-2016-service-manager-cookbook-second-edition/9781786464897
- Microsoft System Center 2016 Orchestrator Cookbook - Second Edition
  - https://www.packtpub.com/product/microsoft-system-center-2016-orchestrator-cookbook-second-edition/9781786460462
- Microsoft System Center Reporting Cookbook
  - https://www.packtpub.com/product/microsoft-system-center-reporting-cookbook/9781782171805
  
