<#
.SYNOPSIS
  Name: ADSiteUpdate.ps1
  The purpose of this script is 
  1. updating AD Site object with new IP subnet provided Network team.
  2. Remove the IP Subnet which not been assigned to any Site/unmatched  based on Data from Network team.
########################################################### 
# AUTHOR  : CY Ryu - IBM KTS
# Created : 03-13-2020
# Updated : 00-00-0000
# CHANGES : update AD Site Object for IP Subnet.
# COMMENT : This script does a bulk modification of IP Subnet Objects in
#           Active Directory based on an input csv.
###########################################################
#>

function AddIPtoAD($IPadd,$SiteCode,$Location,$answer_add){
Try{
switch ($answer_add){
    "1" {
    #New-ADReplicationSubnet -Name $IPadd -Site $SiteCode -Location $Location -WhatIf
    New-ADReplicationSubnet -Name $IPadd -Site $SiteCode -Location $Location -Confirm:$false
    write-host $IPadd ; $SiteCode ; $Location
    Start-Sleep 5
    }
    "2" { Write-host "the operation to add IP $IPadd was skipped." }
    default { write-host "Processing for IP Subnet $IPadd as defined"}
    }
    if($answer_add -eq '1'){
        $Check=Get-ADReplicationSubnet -Filter * | where {$_.Name -like "$IPadd*"}
        if($Check){
        $result="IP subnet $IPName has been Added successfully on AD Site"
        }
        else{
        $result="Checking for updated IP is delayed."
        }
    }

}
Catch{
$ErrorMessage = $_.Exception.Message
$FailedItem = $_.Exception.ItemName
Add-Content $Logfilepath -Value "There`s Some Errors on Adding $IPadd,$SiteCode,$Location to AD:: $ErrorMessage"
$result=$FailedItem,$ErrorMessage ; "Somethings wrong. please check the logs under $Logfilepath"
}
return $result
}
function RemoveIPfromAD($answer_remove,$IP){
Try{
switch ($answer_remove){
    "1" {
    $target=(Get-ADReplicationSubnet -Filter * | where {$_.Name -like "$IP*"}).name
    #Remove-ADReplicationSubnet $targetName -WhatIf
    Remove-ADReplicationSubnet $target -Confirm:$false
    }
    "2" { Write-host "the operation to delete IP $target from AD was skipped." }
    default { write-host "Processing for IP Subnet $IP as defined"}
    }
    $Check=Get-ADReplicationSubnet -Filter * | where {$_.Name -like "$IP*"}
    if(!$Check){
    $result="IP subnet $IPName has been removed successfully from AD Site"
    }
    else{
    $result="There are no errors during operation but IP $IP is still alive."
    }
}
Catch{
$ErrorMessage = $_.Exception.Message
$FailedItem = $_.Exception.ItemName
Add-Content $Logfilepath -Value "There`s some error to remove IP $target from AD:: $ErrorMessage"
$result=$FailedItem,$ErrorMessage ; "Somethings wrong. please check the logs under $Logfilepath"
}
return $result
}
function CompareSubnet($Key,$Hash){
$MatchedItem_Subnet=$null
$j=($hash).count
for($i=0;$i -lt $j;$i++){
$value_Hash_Name=($Hash[$i].Name).Split("{/}")[0]
    if($key -eq $value_Hash_Name){
        $MatchedItem=$Hash[$i]
        }
        #write-host $key, $value_Hash_Name
}
return $MatchedItem
}
Function Get-SiteCodeWithIP($Key,$Hash){
$j=$hash.count
for($i=0;$i -lt $j;$i++){
$value_Hash_Name=($Hash[$i].Name).Split("{/}")[0]
    if($key -eq $value_Hash_Name){
        $Value_Hash_Site=($Hash[$i].Site).Split("{,}")
        $Value_Hash_Site=$Value_Hash_Site[0].Split("{=}")
        $MatchedItem=$Value_Hash_Site[1]
        }

}
return $MatchedItem
}
function Get-SiteCodewithSiteName($Key,$Hash){
$SiteCode=$null
$SiteCity=$null
$sitehash=$hash
$z=$sitehash.count
    for($y=0;$y -lt $z;$y++){
    $SiteCity=$sitehash[$y].City
    #Write-Host $NewIPSite $SiteCity
        if($Key -like $SiteCity){
        $SiteCode=$sitehash[$y].site
        }
    }
return $SiteCode
}
$Filepath_IPranges=Read-Host "where is the file what involving source information for IP ranges?;if you Hit Enter Key, It will be set as C:\Demo\Path"
$Filepath_Sitename=Read-Host "where is the file what involving  mapping information for SiteCodes and SiteNames;if you Hit Enter Key, It will be set as C:\Demo\Path"
$Logfilepath=Read-Host "where is the file for logging?; If you hit Enter Key, It will be set as C:\Demo\Path"
$curruntIPSubnet=Get-ADReplicationSubnet -Filter *
$CurruntADSites=Get-ADReplicationSite -Filter *
if(!$Filepath_IPranges){
$Filepath_IPranges='C:\Demo\Path'
}
if(!$Filepath_Sitename){
$Filepath_Sitename='C:\Demo\Path'
}
if(!$Logfilepath){
$Logfilepath='C:\Demo\Path'
}
Try{
$CheckLogfile=Get-ChildItem $Logfilepath
}
Catch{
Write-host "Log file being created now"
}
if($CheckLogfile){
Try{
rm -Path $Logfilepath
}
Catch{
$ErrorMessage = $_.Exception.Message
$FailedItem = $_.Exception.ItemName
Write-host "No Log file has been found."
}
}
$checkIPfile=Get-ChildItem $Filepath_IPranges
$checkSiteNameFile=Get-ChildItem $Filepath_Sitename
if($checkIPfile -and $checkSiteNameFile){#check source file is exist
$sitehash=import-csv $Filepath_Sitename
$IPrangesHash=import-csv $Filepath_IPranges
$IPranges_add=@()
$IPranges_AssignWrong=@()
$IPranges_AssignWrong_Subnet=@()
$IPranges_AssignWrong_Site=@()
$IPranges_Delete=@()
$IPranges=$null
foreach($IPranges in $curruntIPSubnet){#searching undefined IP subnet on AD
$MatchedItem=$null
$NewIPSubnet=$null
$NewSiteCode=$null
$NewIPSubnet=($IPranges.Name).Split("{/}")[0]
$check_CurrIPrange=$IPrangesHash | Select-String $NewIPSubnet
$key=$NewIPSubnet
$Hash=$IPrangesHash
$MatchedItem=CompareSubnet $Key $Hash
    If(!$MatchedItem){
    #write-host $NewIPSubnet "is not matched with any IP of CSV list"
    $IPranges_Delete+=$NewIPSubnet
    }
}
if($IPranges_Delete){
Write-host $IPranges_Delete
Start-Sleep -s 5
$answer_remove=read-host "there are some IP ranges what assigned AD but defined to anywhere from CSV file. would you conduct to remove those IP from AD?;(1.Remove it 2 or Enter.Not now )"
if($answer_remove -like $null){
$answer_remove='2'
}
$IP=$null
foreach($IP in $IPranges_Delete){
    
    RemoveIPfromAD $answer_remove $IP
    write-host $IP
    }
}
Else{
Write-Host "There are no IP Subnet should be removed from AD"
}
$curruntIPSubnet=Get-ADReplicationSubnet -Filter *
$NewIPSubnet=$null
foreach($IPranges in $IPrangesHash){#Searching wrong assiged IP Subnet on AD
$MatchedItem=$null
$MatchedItem_Site=$null
$check_CurrIPrange=$null
$IPranges_AssignWrong_tmp=$null
$CheckCurrIPrangeCount=$null
$NewIPSubnet=($IPranges.Name).Split("{/}")[0]
$Key=$IPranges.Site
$hash=$Sitehash
$SiteCode = Get-SiteCodewithSiteName $key $hash
if($SiteCode -ne $null){
$check_CurrIPrange=$curruntIPSubnet | select-string $NewIPSubnet
$CheckCurrIPrangeCount=($check_CurrIPrange.line).Lenth
    #if($CheckCurrIPrangeCount -gt 3){
    if($check_CurrIPrange){
    $key=$NewIPSubnet
    $Hash=$curruntIPSubnet
    $MatchedItem=CompareSubnet $Key $Hash
    $Key=$MatchedItem.name
    #$MatchedItem_site=Get-SiteCodeWithIP $Key $Hash
    #Write-host $IPranges
    $CurrSiteCode=(($MatchedItem.site).Split("{,}")[0]).split("{=}")[1]
    $Message_IPranges=$IPranges.name
    $Message_IPranges_Site=$IPranges.site
    $Message_matchedItem=$matchedItem.name
    $Message_matchedItem_Site=$matchedItem.site
        if($SiteCode -eq $CurrSiteCode -and $IPranges.Name -eq $MatchedItem.name){
            #Write-Host "The IP range - $NewIPSubnet had been assigned properly"
            }
        elseif($SiteCode -eq $CurrSiteCode){
            #write-host "Subnet Mask is different between $Message_IPranges and $Message_matchedItem"
            $IPranges_AssignWrong_tmp=New-Object psobject -Property @{IP_CSV=$Message_IPranges;name=$Message_matchedItem}
            $IPranges_AssignWrong_Subnet+=$IPranges_AssignWrong_tmp
            }
        elseif($IPranges.Name -eq $MatchedItem.name){
            #Write-Host "The IP range - $NewIPSubnet had been assigned to Wrong AD Site"
            $IPranges_AssignWrong_tmp=New-Object psobject -Property @{IP_CSV=$Message_IPranges;Site_CSV=$Message_IPranges_Site;name=$Message_matchedItem;Site_ADSite=$Message_matchedItem_Site }
            $IPranges_AssignWrong_Site+=$IPranges_AssignWrong_tmp
            }
    }
    Else{
    #write-host "$NewIPSubnet is not assigned to Anywhere"
    $IPranges_add+=$IPranges
    }
}
else{
write-host "no such site name $key"
}
}
Write-host $IPranges_AssignWrong_Site
Start-Sleep -s 5
if($IPranges_AssignWrong_site){
$answer_remove=read-host "there are some IP ranges what assigned to different Sites based on imported source data. would you conduct to remove those IP from IP_ADSite?;(1.Remove it 2 or Enter.Not now )"
    if($answer_remove -like $null){
    $answer_remove='2'
    }

foreach($IP in $IPranges_AssignWrong_Site){
    $IP=$IP.name
    RemoveIPfromAD $answer_remove $IP
    write-host $IP
    $IP=$null
    }

}
Else{
Write-Host "There are no IP Subnet should be updated on AD"
}

Write-host $IPranges_AssignWrong_Subnet
Start-Sleep -s 5
if($IPranges_AssignWrong_Subnet){
#$IPranges_AssignWrong_Site
$answer_remove=read-host "there are some IP ranges what assigned with different Subnet mask based on imported source data. will you conduct to remove those IP from IP_ADSite?;(1.Remove it 2 or Enter.Not now )"
    if($answer_remove -like $null){
    $answer_remove='2'
    }
foreach($IP in $IPranges_AssignWrong_Subnet){
    $IP=$IP.name
    RemoveIPfromAD $answer_remove $IP
    write-host $IP
    $IP=$null
    }

}
Else{
Write-Host "There are no IP Subnet should be updated on AD"
}

if($IPranges_add){
Write-host $IPranges_add
Start-Sleep -s 5
$answer_add=read-host "there are some IP ranges what can be added to AD based on imported source data. will you conduct to add those IP from AD?;(1.Add 2 or Enter.Not now)"
if($answer_add -like $null){
$answer_add='2'
}
    $IP=$null
    foreach($IP in $IPranges_add){
        $Key=($IP.name).Split("{/}")[0]
        $Hash=$IPrangesHash
        $MatchedItem=compareSubnet $key $Hash
        $IPadd=$MatchedItem.name
        $Location=$IP.site
        $Key=$MatchedItem.Site
        $Hash=$sitehash
        $SiteCode=Get-SiteCodewithSiteName $Key $Hash
        #$IPadd ; $SiteCode ; $Location ;$answer_add ; $Key
        AddIPtoAD $IPadd $SiteCode $Location $answer_add
        }
}
Else{
Write-Host "There are no IP Subnet should be Added to AD"
}
}

Else{
Write-Host "There are no source file(s) for SiteName or IPranges information"
}


