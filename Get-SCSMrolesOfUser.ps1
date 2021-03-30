# Author: Anton Gritsenke - freemanru[at]gmail[dot]com
# Posted the script here withe the permission of Anton

$userName = "SCSMSOL\geocall"
 
Import-Module SMLets
# operation ID is same for all
$mg = New-SCSMSession -PassThru
$idOperation_Object__Get = [guid]"e8b526b8-2404-4b2a-ab56-db3d9c7ef6aa"
$mg.Security.GetUserRolesForOperationAndUser($idOperation_Object__Get, $userName) | %{
    # also implicite roles are exist here, and they will throw exception
    try{
        $role = $mg.Security.GetUserRole($_)
        $role  | select DisplayName, ProfileDisplayName, IsSystem | ft
    }
    catch{}
}