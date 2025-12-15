Function CheckCurrentZone($currentzone,$ForwarderIP1,$ForwarderIP2,$ForwarderIP3){
    $targetDomains=@()
    $fixedTargets=@()
    $targetDomains+='Test.com';$targetDomains+='Contoso.com';$targetDomains+='example.com';$targetDomains+='Contoso.corp';$targetDomains+='tradewind.co.kr';$targetDomains+='northtrade.com';$targetDomains+='southteck.com'
    $ForwarderIPs="$ForwarderIP1 $ForwarderIP2 $ForwarderIP3"
    foreach($targetDomain in $targetDomains){
    $chk_result=$null
    $chk_resultIP=$null
    $chk_result=$currentzone | findstr /I $targetDomain
        if($chk_result -eq $null){
        $fixedTargets+=$targetDomain
        }
        Else{
        $chk_resultIP=$chk_result | findstr /I $ForwarderIPs
        if($chk_resultIP -eq $null){
        $fixedTargets+=$targetDomain
        }
        }
    }
return $fixedTargets
}

Function UpdateConditionalForwarderZone($hostname,$fixedTargets,$ForwarderIP1,$ForwarderIP2,$ForwarderIP3,$currentzone){
    foreach($name in $fixedTargets){
    $Check_Currentzone=$null
    $Check_Currentzone=$currentzone | findstr /I $name
        If($Check_Currentzone -eq $null){
        Add-DnsServerConditionalForwarderZone -Computername $hostname -Name $name -MasterServers $ForwarderIP1,$ForwarderIP2,$ForwarderIP3 -Verbose
        }
      
        Else{
        Set-DnsServerConditionalForwarderZone -Computername $hostname -Name $name -MasterServers $ForwarderIP1,$ForwarderIP2,$ForwarderIP3 -Verbose
        }
    }
}


$Path_sourcefile = read-host "Please input the Specific AD DNS server name (if you hit just enter, default C:\Demo\Path"
$Check_DCName=Get-addomainController -identity $Path_sourcefile
If($Check_DCName){
$Region = read-host "please input the region of AD DNS"
$sourcefilechecking=New-Object psobject -Property @{hostname=$Check_DCName.hostname;region=$Region}
}
Else{
$sourcefilechecking = Get-ChildItem 'C:\Demo\Path'
}
if($sourcefilechecking -notlike $null){
    if($Check_DCName){
    $sourceData=$sourcefilechecking
    }
    else{
    $sourceData=import-csv $sourcefilechecking
    }
    foreach($ADServer in $sourceData){
    $hostname=$null
    $region=$null
    $currentzone=$null
    $hostname=$ADServer.hostname
    $region=$ADServer.region
    Switch($region){
        APAC{$ForwarderIP1='1.1.1.100';$ForwarderIP2='1.1.1.110';$ForwarderIP3='1.1.1.120'}
        EMEA{$ForwarderIP1='2.2.2.100'; $ForwarderIP2='2.2.2.110';$ForwarderIP3='2.2.2.120'}
        America{$ForwarderIP1='3.3.3.100'; $ForwarderIP2='3.3.3.110';$ForwarderIP3='3.3.3.120'}
        }
    $currentzone=get-dnsserverzone -ComputerName $hostname | where {$_.zonetype -like 'Forwarder' -and $_.IsDsIntegrated -eq $false} | fl Zonename,MasterServers
    $fixedTargets = CheckCurrentZone $currentzone $ForwarderIP1 $ForwarderIP2  $ForwarderIP3
    write-host $hostname $region $ForwarderIP1 $ForwarderIP2 $ForwarderIP3 $fixedTargets
    UpdateConditionalForwarderZone $hostname $fixedTargets $ForwarderIP1 $ForwarderIP2 $ForwarderIP3 $currentzone
    #get-service -computername $hostname -Name DNS | restart-service
    }
    

}
Else{
write-host "no source file has been founded"
}