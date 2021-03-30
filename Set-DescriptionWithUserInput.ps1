# Import SMlets module
Import-Module smlets -force 2>&1

#------ Variables ------

# ID of the Service Request
$id = "SR320472"

# Name of the SCSM Management Server
$smDefaultComputer = "scsm1"

#----- Magic starts here ------------------

# Get Service Request Class
$srClass = Get-SCSMClass -Name System.WorkItem.ServiceRequest$

#Get Service Request Object
$srObject = Get-SCSMObject -Class $srClass -Filter "Id = $id"

# Get User Input of Service Request
$userInputContent = [XML]$srObject.UserInput

#$userInputContent = [XML]$xmlUserInput
$questions = $userInputContent.UserInputs.UserInput

# Clear useInput variable
$userInput = ""

# If Service Request Description is not empty
if ($srObject.Description)
{
    # Build UserInput with existing description
    $userInput+= $srObject.Description + [Environment]::NewLine +  "---------------" + [Environment]::NewLine
}
# For each line in User Input of SR
foreach ($input in $questions)
{
    # If Input contains Answer Value
    if($($input.Answer) -like "<Value*")
    {  
        # Set answer variable     
        [xml]$answer = $input.Answer
        # for each answer varaible ...
        foreach($value in $answer.Values)
        {
                # For each item in value variable
                foreach($item in $value)
                {                   
                    # For each text in Item Value
                    foreach ($txt in $($item.Value))
                    {   # Build list                   
                        $listArray += $($txt.DisplayName)                  
                    }

                    # Build User Input 
                    $userInput += $input.Question + " = " + [string]::Join(" ; ",$listArray) + [Environment]::NewLine
                    $ListArray = $null
                }
        }
    }
    else 
    {
            # If Input Type is a List Value
            if ($input.Type -eq "enum")
            {
            $listGuid = Get-SCSMEnumeration -Id $input.Answer
            $userInput+= $($input.Question + " = " + $listGuid.Displayname)  + [Environment]::NewLine
            }
            # If Input Type is Date/Time value
            if ($input.Type -eq "datetime")
            {
            # Set date property
            $date = [DateTime]$input.Answer
            # Format Date/Time 
            $date = $date.ToString("dd.MM.yyy")
            # Build User Input
            $userInput+= $($input.Question + " = " + $date)  + [Environment]::NewLine
            }

        else 
            {
            # Build User Input
            $userInput += $($input.Question + " = " + $input.Answer)  + [Environment]::NewLine
            }
    }
}

# Build property has for update
$propertyHash = @{
	            Description = $userInput
                }
# Update of Service Request Description field 
$srObject | Set-SCSMObject -PropertyHashtable $propertyHash