<#
.SYNOPSIS
  Name: Get-PCInfo.ps1
  The purpose of this script is to retrieve basic information of a PC.
########################################################### 
# AUTHOR  : CY Ryu - IBM KTS
# Created : 01-17-2020
# Updated : 02-18-2020
# CHANGES : update user`s attribute 'l','company' as data 
#           from specified CSV file.
# COMMENT : This script does a bulk modification of users in
#           Active Directory based on an input csv and the
#           Active Directory Module. 
###########################################################
#>
Param(
[string]$Computer
)

$Mode=read-host "Choose multiple or Single 1. Single 2. Multiple"
Switch($Mode){
1{
    if($Computer -like $null){
    $Computer=Read-Host "Input the name of the Target Machine or Just Enter Key(to select this Local Machine as a Target Machine)"}
    if($Computer -like $null){
    $Computer = (Get-WmiObject -Class Win32_ComputerSystem).name
    }
}
2{
$Targetservers=Import-csv C:\Demo\Path
del $FilePath
If($Computer){}
foreach($Target in $Targetservers){
$computer=$Target.hostname

#Write-host "The Output File has been created at $FilePath"
}
}
3{
$Computer=Hostname
}
}
$FilePath=Read-Host "Do you want specific path for the output file? 
input the Full path (Ex - C:\Demo\Path"
If($FilePath -like $null){
$FilePath='C:\Demo\Path'
}

$Ownedby=Read-Host "Ownedby? (Ex: Customer or IBM... Hit the Enter Key if you do not need to fill out at this time)"
$OutputType = Read-Host "what is desired type for the outcome? (1. normal csv file / 2. normal text file)"
Write-host $Computer
$Connection = Test-Connection $Computer -Count 1 -Quiet
if ($Connection -eq "True"){
   $computerBios = gwmi win32_bios -ComputerName $Computer
   $ComputerHW = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $Computer
   $hostname=$computerHW.Name
   $ModelID=$ComputerHW.Model
   $ComputerCPU = @(Get-WmiObject -class Win32_processor -ComputerName $Computer | select *)
   $CPUcount=$ComputerCPU.count
   $ComputerRam_Total = Get-WmiObject Win32_PhysicalMemoryArray -ComputerName $Computer
   $ComputerRAM=Get-WmiObject Win32_PhysicalMemory -ComputerName $Computer
   $TotalMemory=$null
   if($computerRAM.count -gt '1'){
   for($i=0;$i -lt $computerRAM.count;$i++){
   $TotalMemory=$TotalMemory+$computerRAM[$i].capacity
   }
   $TotalMemory=($TotalMemory/1GB).tostring()+"GB"
   }
   Else{
   $TotalMemory=($ComputerRAM.Capacity/1GB).tostring()+"GB"
   }
   $ComputerDisks_All = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -ComputerName $Computer
   $DiskInfo=$null
   If($ComputerDisks_All.count -gt '1'){
   for($i=0;$i -lt $ComputerDisks_All.count;$i++){
   $DiskSize_tmp=("{0:N2}" -f ($ComputerDisks_All[$i].size/1GB)).ToString()+"GB"
   $DeviceID=$ComputerDisks_All[$i].DeviceID
   $DiskInfo += "$DeviceID$DiskSize_tmp "
   }
   }
   else{
   $DiskSize_tmp=("{0:N2}" -f ($ComputerDisks_All.size/1GB)).ToString()+"GB"
   $DeviceID=$ComputerDisks_All.DeviceID
   $DiskInfo = "$DeviceID$DiskSize_tmp"
   }
   $ComputerOS = Get-WmiObject Win32_OperatingSystem -ComputerName $Computer
   #$IPaddresses=@(Get-NetIPAddress | where {$_.AddressFamily -eq 'IPv4'} | select IPAddress)
   #$IPaddresses=@(Get-WMIObject win32_NetworkAdapterConfiguration -ComputerName $Computer | Where-Object { $_.IPEnabled -eq $true } | Foreach-Object { $_.IPAddress })
   $IPaddresses=@((Get-WMIObject win32_NetworkAdapterConfiguration -ComputerName $Computer | Where-Object { $_.IPEnabled -eq $true }).ipaddress)
   #$IPaddresses
    if($computerBios.SerialNumber -like 'VMware*'){
    $IsVirtual=$True} 
    else {
    $IsVirtual=$False}
   $CheckMonitoring=Get-Process -ComputerName $Computer | findstr /I "wmi_" 
    If($CheckMonitoring){
    $isMonitoring = $True
    #$MonitoringIn = (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | where {$_.Displayname-like "WMI Exporter"} | Select-Object InstallDate).InstallDate
    $MonitoringIn = (Get-WmiObject -Class Win32_Product -computer $Computer| where {$_.Name -like "WMI Exporter"} | fl * | findstr /I "installdate")
    try{
    $MonitoringIn=$MonitoringIn.split("{:}")}
    catch{
    $MonitoringIn=$MonitoringIn -split ":"}
    try{
    $MonitoringIn=$MonitoringIn[1].Trim()}
    Catch{
    }
    }
   else{
   $isMonitoring = $False
   $MonitoringIn = "N/A"
   }
   $TotalLogicalCPU=$null
   $TotalPhysicalCPU=$null
   for($i=0;$i -lt $CPUCount;$i++){
    $TotalLogicalCPU=$TotalLogicalCPU+$ComputerCPU[0].NumberOfLogicalProcessors
    $TotalPhysicalCPU=$TotalPhysicalCPU+$ComputerCPU[0].NumberOfCores
    }
    $systeminfo = [pscustomobject]@{
    Hostname=$ComputerHW.name
    Serials=$computerBios.SerialNumber
    Machinetype=$ComputerHW.Model
    CPUmodel=$ComputerHW.Model
    HWowner="Customer"	
    ProcessorManufacturer=$ComputerCPU[0].Manufacturer
    MastProcessorType=$ComputerCPU[0].Name.split("{ }")[1]
    ProcessorModel=$ComputerCPU[0].Name.split("{ }")[3]
    NBRCoresPerChip=$ComputerCPU[0].NumberOfCores
    HWChips=$ComputerCPU.count
    HWProcessorCount=$TotalPhysicalCPU
    NBROfChipsMax=$ComputerCPU.count
    }
    }
else {
Write-Host -ForegroundColor Red "Computer is not reachable or does not exists."
}


#write-host $systeminfo | fl
#if($FilePath){
$Filepath="$FilePath$hostname.csv"
#}
#Else{
#$FilePath="$env:USERPROFILE\Documents\$hostname.csv"
#}
if(!$OutputType){
$OutputType='1'
}
switch ($OutputType){
1{$systeminfo | Export-csv $FilePath -Encoding UTF8 -Append}
2{$systeminfo | Out-file $FilePath -Encoding UTF8}
}





#Write-Host -BackgroundColor DarkYellow -ForegroundColor DarkGreen "Please input the data what should be entered manually..
#If you hit just Enter Key, that column will be written as blank"
#$BusinessCriticality=Read-Host "BusinessCriticality? (ex: Gold, Silver, Bronze.. Hit the Enter Key if you do not need to fill out)"
#$Region=Read-Host "Region? (ex: Korea, US.. Hit the Enter Key if you do not need to fill out at this time)"
#$Location=Read-Host "Location? (Ex: Daejeon, Bangalore... Hit the Enter Key if you do not need to fill out at this time)"
#$Description=Read-Host "Description? (Hit the Enter Key if you do not need to fill out at this time)"
#$Classification=Read-Host "Classification? (Ex: Production, Development... Hit the Enter Key if you do not need to fill out at this time)"





