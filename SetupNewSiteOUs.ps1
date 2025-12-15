$SiteCodes=import-csv C:\Demo\Path
foreach($Sitecode in $SiteCodes){
$Sitecode=$SiteCode.sitecode
Write-host "Working for $sitecode"
$SiteOUPath=(Get-ADOrganizationalUnit -Filter * | where{$_.Name -like "*$SiteCode*" -and $_.DistinguishedName -notlike "*OU=UserIDs*" -and $_.DistinguishedName -notlike "*North*" -and $_.DistinguishedName -notlike "*South*"}).Distinguishedname
If($SiteOUPath){
Write-host $SiteOUPath
    $CheckOUPath_Accounts="OU=Accounts,$siteoupath"
    $CheckOUPath_Service="OU=ServiceAccounts,OU=Accounts,$siteoupath"
    $CheckOUPath_Partner="OU=PartnerAccounts,OU=Accounts,$siteoupath"
    $CheckOUPath_Admin="OU=AdminAccounts,OU=Accounts,$siteoupath"
    $CheckOUPath_Supplier="OU=SupplierAccounts,OU=Accounts,$siteoupath"
    $CheckOUPath_Disabled="OU=Disabled,OU=Accounts,$siteoupath"
    $CheckOUPath_Users="OU=Users,OU=Accounts,$siteoupath"
    $CheckOUPath_Servers="OU=Servers,$siteoupath"
    $CheckOUPath_ServersExclusion="OU=Exclusion,OU=Servers,$siteoupath"
    $CheckOUPath_Computers="OU=Computers,$siteoupath"
    $CheckOUPath_Groups="OU=Groups,$siteoupath"
    $CheckOUPath_DisabledComputers="OU=Disabled Computers,OU=Computers,$siteoupath"
    $CheckOUPath_EIT="OU=EIT,OU=Computers,$siteoupath"
    $CheckOUPath_Exclusion="OU=Exclusion,OU=Computers,$siteoupath"
    $CheckOUPath_NewComputers="OU=NewComputers,OU=Computers,$siteoupath"
    $CheckOUPath_Office="OU=Office,OU=Computers,$siteoupath"
    $CheckOUPath_PlantFloor="OU=PlantFloor,OU=Computers,$siteoupath"
    $CheckGroupName_GroupsManager="GF-$SiteCode-Groups-Manager-GG"
    $CheckGroupName_ComputerAdmins="GG-$SiteCode-Computer-Admins-GG"
    $CheckGroupName_ComputerMove="GG-$SiteCode-Computer-Move-GG"
    $CheckGroupName_GroupEditor="GG-$SiteCode-Groups-Editor-GG"
    $CheckGroupName_LogonScriptEditor="GG-$SiteCode-LogonScript-Editor-GG"
    $CheckGroupName_SCCMAdmins="GG-$SiteCode-SCCM-Admins"
    $CheckGroupName_ServerAdmins="GG-$SiteCode-Server-Admins-GG"
    Try{
    $Check_AccountsOU=$null
    $Check_AccountsOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Accounts
    Write-host "OU Accounts trying to create is already exist"
    }
    Catch{
    Write-host "There`re no Accounts OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$Check_AccountsOU){
    New-ADOrganizationalUnit -Name "Accounts" -Path $siteoupath
    }
    }
    Try{
    $check_ServiceAccountsOU=$null
    $check_ServiceAccountsOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Service
    Write-host "OU ServiceAccounts trying to create is already exist"
    }
    Catch{
    Write-host "There are no ServiceAccounts OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$check_ServiceAccountsOU){
    New-ADOrganizationalUnit -Name "ServiceAccounts" -Path "OU=Accounts,$siteoupath"
    }
    }
    Try{
    $check_PartnerAccountsOU=$null
    $check_PartnerAccountsOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Partner
    Write-host "OU PartnerAccounts trying to create is already exist"
    }
    Catch{
    Write-host "There are no PartnerAccounts OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$check_PartnerAccountsOU){
    New-ADOrganizationalUnit -Name "PartnerAccounts" -Path "OU=Accounts,$siteoupath"
    }
    }
    Try{
    $check_AdminAccountsOU=$null
    $check_AdminAccountsOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Admin
    Write-host "OU AdminAccounts trying to create is already exist"
    }
    Catch{
    Write-host "There are no AdminAccounts OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$check_AdminAccountsOU){
    New-ADOrganizationalUnit -Name "AdminAccounts" -Path "OU=Accounts,$siteoupath"
    }
    }
    Try{
    $check_DisabledOU=$null
    $check_DisabledOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Disabled
    Write-host "OU Disabled trying to create is already exist"
    }
    Catch{
    Write-host "There are no Disabled OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$check_DisabledOU){
    New-ADOrganizationalUnit -Name "Disabled" -Path "OU=Accounts,$siteoupath"
    }
    }
    Try{
    $check_SupplierOU=$null
    $check_SupplierOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Supplier
    Write-host "OU Supplier trying to create is already exist"
    }
    Catch{
    Write-host "There are no Supplier OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$check_SupplierOU){
    New-ADOrganizationalUnit -Name "SupplierAccounts" -Path "OU=Accounts,$siteoupath"
    }
    }
    Try{
    $check_UsersOU=$null
    $check_UsersOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Users
    Write-host "OU Users trying to create is already exist"
    }
    Catch{
    Write-host "There are no Users OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$check_UsersOU){
    New-ADOrganizationalUnit -Name "Users" -Path "OU=Accounts,$siteoupath"
    }
    }
    Try{
    $check_ServersOU=$null
    $check_ServersOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Servers
    Write-host "OU Servers trying to create is already exist"
    }
    Catch{
    Write-host "There are no Servers OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$check_ServersOU){
    New-ADOrganizationalUnit -Name "Servers" -Path "$siteoupath"
    }
    }
    Try{
    $check_ComputersOU=$null
    $check_ComputerOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Computers
    Write-host "OU Computers trying to create is already exist"
    }
    Catch{
    Write-host "There are no Computers OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$check_ComputersOU){
    New-ADOrganizationalUnit -Name "Computers" -Path "$siteoupath"
    }
    }
    Try{
    $check_GroupsOU=$null
    $check_GroupsOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Groups
    Write-host "OU Groups trying to create is already exist"
    }
    Catch{
    Write-host "There are no Groups OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$check_GroupsOU){
    New-ADOrganizationalUnit -Name "Groups" -Path "$siteoupath"
    }
    }
    Try{
    $Check_DisabledComputersOU=$null
    $Check_DisabledComputersOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_DisabledComputers
    Write-host "OU Disabled Computers trying to create is already exist"
    }
    Catch{
    Write-host "There are no Disabled Computers OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$Check_DisabledComputersOU){
    New-ADOrganizationalUnit -Name "Disabled Computers" -Path "OU=Computers,$siteoupath"
    }
    }
    Try{
    $Check_EITOU=$Null
    $Check_EITOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_EIT
    Write-host "OU EIT trying to create is already exist"
    }
    Catch{
    Write-host "There are no EIT OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$Check_EITOU){
    New-ADOrganizationalUnit -Name "EIT" -Path "OU=Computers,$siteoupath"
    }
    }
    Try{
    $Check_ExclusionOU=$Null
    $Check_ExclusionOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Exclusion
    Write-host "OU Exclusion trying to create is already exist"
    }
    Catch{
    Write-host "There are no Exclusion OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$Check_ExclusionOU){
    New-ADOrganizationalUnit -Name "Exclusion" -Path "OU=Computers,$siteoupath"
    }
    }
    Try{
    $Check_NewComputersOU=$null
    $Check_NewComputersOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_NewComputers
    Write-host "OU NewComputers trying to create is already exist"
    }
    Catch{
    Write-host "There are no NewComputers OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$Check_NewComputersOU){
    New-ADOrganizationalUnit -Name "NewComputers" -Path "OU=Computers,$siteoupath"
    }
    }
    Try{
    $Check_OfficeOU=$null
    $Check_OfficeOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_Office
    Write-host "OU Office trying to create is already exist"
    }
    Catch{
    Write-host "There are no Office OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$Check_OfficeOU){
    New-ADOrganizationalUnit -Name "Office" -Path "OU=Computers,$siteoupath"
    }
    }
    Try{
    $Check_PlantFloorOU=$null
    $Check_PlantFloorOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_PlantFloor
    Write-host "OU PlantFloor trying to create is already exist"
    }
    Catch{
    Write-host "There are no PlantFloor OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$Check_PlantFloorOU){
    New-ADOrganizationalUnit -Name "PlantFloor" -Path "OU=Computers,$siteoupath"
    }
    }    
    Try{
    $Check_ServersExclusionOU=$Null
    $Check_ServersExclusionOU=Get-ADOrganizationalUnit -Identity $CheckOUPath_ServersExclusion
    Write-host "OU Server Exclusion trying to create is already exist"
    }
    Catch{
    Write-host "There are no Server Exclusion OU in Site Code $SiteCode. Making OU under objective site OU"
    if(!$Check_ServersExclusionOU){
    New-ADOrganizationalUnit -Name "Exclusion" -Path "OU=Servers,$siteoupath"
    }
 
}

#Creating Permission Group for delegation.
    Try{
    $Check_PermissionGroup=$Null
    $Check_PermissionGroup=Get-ADGroup -Identity $CheckGroupName_GroupsManager
    Write-host "Group $CheckGroupName_GroupsManager trying to create is already exist"
    }
    Catch{
    Write-host "There are no Permission Group $CheckGroupName_GroupsManager in $SiteCode. Making Group under objective site OU"
    if(!$Check_PermissionGroup){
    New-ADGroup -verbose -Name $CheckGroupName_GroupsManager -SamAccountName $CheckGroupName_GroupsManager -GroupCategory Security -GroupScope Global -DisplayName $CheckGroupName_GroupsManager -Path $CheckOUPath_Groups -Description "Members of this group does have full permission for managing all local Site Groups"
    }
    }
    Try{
    $Check_PermissionGroup=$Null
    $Check_PermissionGroup=Get-ADGroup -Identity $CheckGroupName_ComputerAdmins
    Write-host "Group $CheckGroupName_ComputerAdmins trying to create is already exist"
    }
    Catch{
    Write-host "There are no Permission Group $CheckGroupName_ComputerAdmins in $SiteCode. Making Group under objective site OU"
    if(!$Check_PermissionGroup){
    New-ADGroup -verbose -Name $CheckGroupName_ComputerAdmins -SamAccountName $CheckGroupName_ComputerAdmins -GroupCategory Security -GroupScope Global -DisplayName $CheckGroupName_ComputerAdmins -Path $CheckOUPath_Groups -Description "Members of this group does have full permission for managing all local Computer Object under the Computers OU"
    }
    }
    Try{
    $Check_PermissionGroup=$Null
    $Check_PermissionGroup=Get-ADGroup -Identity $CheckGroupName_ComputerMove
    Write-host "Group $CheckGroupName_ComputerMove trying to create is already exist"
    }
    Catch{
    Write-host "There are no Permission Group $CheckGroupName_ComputerMove in $SiteCode. Making Group under objective site OU"
    if(!$Check_PermissionGroup){
    New-ADGroup -verbose -Name $CheckGroupName_ComputerMove -SamAccountName $CheckGroupName_ComputerMove -GroupCategory Security -GroupScope Global -DisplayName $CheckGroupName_ComputerMove -Path $CheckOUPath_Groups -Description "Members of this group does have only permission to move all local Computer Object into the Computers OU"
    }
    }
    Try{
    $Check_PermissionGroup=$Null
    $Check_PermissionGroup=Get-ADGroup -Identity $CheckGroupName_GroupEditor
    Write-host "Group $CheckGroupName_GroupEditor trying to create is already exist"
    }
    Catch{
    Write-host "There are no Permission Group $CheckGroupName_GroupEditor in $SiteCode. Making Group under objective site OU"
    if(!$Check_PermissionGroup){
    New-ADGroup -verbose -Name $CheckGroupName_GroupEditor -SamAccountName $CheckGroupName_GroupEditor -GroupCategory Security -GroupScope Global -DisplayName $CheckGroupName_GroupEditor -Path $CheckOUPath_Groups -Description "Members of this group does have only permission to edit the Group Members of Local Groups"
    }
    }
    Try{
    $Check_PermissionGroup=$Null
    $Check_PermissionGroup=Get-ADGroup -Identity $CheckGroupName_LogonScriptEditor
    Write-host "Group $CheckGroupName_LogonScriptEditor trying to create is already exist"
    }
    Catch{
    Write-host "There are no Permission Group $CheckGroupName_LogonScriptEditor in $SiteCode. Making Group under objective site OU"
    if(!$Check_PermissionGroup){
    New-ADGroup -verbose -Name $CheckGroupName_LogonScriptEditor -SamAccountName $CheckGroupName_LogonScriptEditor -GroupCategory Security -GroupScope Global -DisplayName $CheckGroupName_LogonScriptEditor -Path $CheckOUPath_Groups -Description "Members of this group does have full permission to edit Logon Script located in Sysvol"
    }
    }
    Try{
    $Check_PermissionGroup=$Null
    $Check_PermissionGroup=Get-ADGroup -Identity $CheckGroupName_SCCMAdmins
    Write-host "Group $CheckGroupName_SCCMAdmins trying to create is already exist"
    }
    Catch{
    Write-host "There are no Permission Group $CheckGroupName_SCCMAdmins in $SiteCode. Making Group under objective site OU"
    if(!$Check_PermissionGroup){
    New-ADGroup -verbose -Name $CheckGroupName_SCCMAdmins -SamAccountName $CheckGroupName_SCCMAdmins -GroupCategory Security -GroupScope Global -DisplayName $CheckGroupName_SCCMAdmins -Path $CheckOUPath_Groups -Description "Members of this group does have permission would be needed for SCCM Client management"
    }
    }
    Try{
    $Check_PermissionGroup=$Null
    $Check_PermissionGroup=Get-ADGroup -Identity $CheckGroupName_ServerAdmins
    Write-host "Group $CheckGroupName_ServerAdmins trying to create is already exist"
    }
    Catch{
    Write-host "There are no Permission Group $CheckGroupName_ServerAdmins in $SiteCode. Making Group under objective site OU"
    if(!$Check_PermissionGroup){
    New-ADGroup -verbose -Name $CheckGroupName_ServerAdmins -SamAccountName $CheckGroupName_ServerAdmins -GroupCategory Security -GroupScope Global -DisplayName $CheckGroupName_ServerAdmins -Path $CheckOUPath_Groups -Description "Members of this group does have full permission for managing all local Server Object"
    }
    }
 }
}

foreach($Sitecode in $SiteCodes){
$Sitecode=$SiteCode.sitecode
Write-host "Working for $sitecode"
$SiteOUPath=(Get-ADOrganizationalUnit -Filter * | where{$_.Name -like "*$SiteCode*" -and $_.DistinguishedName -notlike "*OU=UserIDs*" -and $_.DistinguishedName -notlike "*North*" -and $_.DistinguishedName -notlike "*South*"}).Distinguishedname
If($SiteOUPath){
Write-host $SiteOUPath
    $CheckOUPath_Accounts="OU=Accounts,$siteoupath"
    $CheckOUPath_Service="OU=ServiceAccounts,OU=Accounts,$siteoupath"
    $CheckOUPath_Partner="OU=PartnerAccounts,OU=Accounts,$siteoupath"
    $CheckOUPath_Admin="OU=AdminAccounts,OU=Accounts,$siteoupath"
    $CheckOUPath_Supplier="OU=SupplierAccounts,OU=Accounts,$siteoupath"
    $CheckOUPath_Disabled="OU=Disabled,OU=Accounts,$siteoupath"
    $CheckOUPath_Users="OU=Users,OU=Accounts,$siteoupath"
    $CheckOUPath_Servers="OU=Servers,$siteoupath"
    $CheckOUPath_ServersExclusion="OU=Exclusion,OU=Servers,$siteoupath"
    $CheckOUPath_Computers="OU=Computers,$siteoupath"
    $CheckOUPath_Groups="OU=Groups,$siteoupath"
    $CheckOUPath_DisabledComputers="OU=Disabled Computers,OU=Computers,$siteoupath"
    $CheckOUPath_EIT="OU=EIT,OU=Computers,$siteoupath"
    $CheckOUPath_Exclusion="OU=Exclusion,OU=Computers,$siteoupath"
    $CheckOUPath_NewComputers="OU=NewComputers,OU=Computers,$siteoupath"
    $CheckOUPath_Office="OU=Office,OU=Computers,$siteoupath"
    $CheckOUPath_PlantFloor="OU=PlantFloor,OU=Computers,$siteoupath"
    $CheckGroupName_GroupsManager="GF-$SiteCode-Groups-Manager-GG"
    $CheckGroupName_ComputerAdmins="GG-$SiteCode-Computer-Admins-GG"
    $CheckGroupName_ComputerMove="GG-$SiteCode-Computer-Move-GG"
    $CheckGroupName_GroupEditor="GG-$SiteCode-Groups-Editor-GG"
    $CheckGroupName_LogonScriptEditor="GG-$SiteCode-LogonScript-Editor-GG"
    $CheckGroupName_SCCMAdmins="GG-$SiteCode-SCCM-Admins"
    $CheckGroupName_ServerAdmins="GG-$SiteCode-Server-Admins-GG"
#Set GPO Inheritance Block
    $InheritanceCheck=(Get-GPInheritance -Target $CheckOUPath_Exclusion).GpoInheritanceBlocked
    If(!$InheritanceCheck){
    Set-GPInheritance -Target $CheckOUPath_Exclusion -IsBlocked Yes -Verbose
    }
#Add Groups into the Groups    
Function AddToGroup ($TargetGroup,$GroupAdded){    
    
    Add-ADGroupMember -Identity $TargetGroup -Members $GroupAdded -Verbose
    
    
    Write-host "$GroupAdded Is already member of $TargetGroup"
    
}
$targetGroup = "Global IT Computer Object move"
AddToGroup $TargetGroup $CheckGroupName_ComputerMove
AddToGroup $CheckGroupName_ComputerMove $CheckGroupName_ComputerAdmins
AddToGroup $CheckGroupName_ComputerMove $CheckGroupName_ServerAdmins
$targetGroup = "Top_PermissionGroup_EditScirptofSYSVOL"
AddToGroup $TargetGroup $CheckGroupName_LogonScriptEditor

#ACL updates
function SetACL ($targetGroup,$TargetOU,$TargetType,$PermissionType){
    $Groupobj=Get-ADGroup $targetGroup
    $Gname=$Groupobj.name
    $GroupSID = [System.Security.Principal.SecurityIdentifier] $Groupobj.sid
    $ACL = Get-Acl -Path "AD:\$TargetOU"
    $Group_SchGUID=[GUID]"bf967a9c-0de6-11d0-a285-00aa003049e2"
    $Computer_SchGUID=[GUID]"bf967a86-0de6-11d0-a285-00aa003049e2"
    $CheckPrvACL=$ACL | Where {$_.identityreference -like "*$GName*"}
    If($CheckPrvACL=$ACL){
    $ACL.RemoveAccessRule($AclRule)
    Set-Acl -Path "AD:\$TargetOU" -AclObject $ACL -Verbose
    }
    Switch($TargetType){
        "Computer"{
            Switch($PermissionType){
            "GenericAll"{
            $AclRule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($GroupSID, "GenericAll", "Allow", $Computer_SchGUID, "All")
            }
            "Limited" {
            $AclRule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($GroupSID, "CreateChild, DeleteChild, WriteProperty", "Allow", $Computer_SchGUID, "All")
            }
            }
        }
        "Group"{
            Switch($PermissionType){
            "GenericAll"{
            $AclRule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($GroupSID, "GenericAll", "Allow",$Group_SchGUID,"All")
            }
            "Limited"{
            $guidGroupMembership = new-object GUID "bc0ac240-79a9-11d0-9020-00c04fc2d4cf"
            $AclRule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($GroupSID, "readProperty, WriteProperty", "Allow", $Group_SchGUID, "All")
            }
            }
        }
    }
    $ACL.AddAccessRule($AclRule)
    Set-Acl -Path "AD:\$TargetOU" -AclObject $ACL -Verbose
}

$targetGroup=$CheckGroupName_GroupsManager
$TargetOU=$CheckOUPath_Groups
$TargetType="Group"
$PermissionType="GenericAll"
SetACL $targetGroup $TargetOU $TargetType $PermissionType

$targetGroup=$CheckGroupName_GroupEditor
$TargetOU=$CheckOUPath_Groups
$TargetType="Group"
$PermissionType="Limited"
SetACL $targetGroup $TargetOU $TargetType $PermissionType

$targetGroup=$CheckGroupName_ComputerAdmins
$TargetOU=$CheckOUPath_Computers
$TargetType="Computer"
$PermissionType="GenericAll"
SetACL $targetGroup $TargetOU $TargetType $PermissionType

$targetGroup=$CheckGroupName_ComputerMove
$TargetOU=$CheckOUPath_Computers
$TargetType="Computer"
$PermissionType="Limited"
SetACL $targetGroup $TargetOU $TargetType $PermissionType
    
$targetGroup=$CheckGroupName_SCCMAdmins
$TargetOU=$CheckOUPath_Computers
$TargetType="Computer"
$PermissionType="Limited"
SetACL $targetGroup $TargetOU $TargetType $PermissionType

$targetGroup=$CheckGroupName_SCCMAdmins
$TargetOU=$CheckOUPath_Servers
$TargetType="Computer"
$PermissionType="Limited"
SetACL $targetGroup $TargetOU $TargetType $PermissionType

$targetGroup=$CheckGroupName_ServerAdmins
$TargetOU=$CheckOUPath_Servers
$TargetType="Computer"
$PermissionType="GenericAll"
SetACL $targetGroup $TargetOU $TargetType $PermissionType

 }
 }

 Write-host "Job`s done!"