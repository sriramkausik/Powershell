Function MonitorEventlog{

    $Currentdate = get-date
    
    write-host "============================================================================================================================="
    Write-Host "                                                                                                                             "
    Write-Host "The script started at $Currentdate and will run for every minute for the next 3 hours to monitor the patch failure"
    Write-Host "                                                                                                                             "
    write-host "============================================================================================================================="

    for ($i=0;$i -lt 200;$i++)
    {

    Start-Sleep -Seconds 60
    $Date=(get-date).AddMinutes(-1)
    
    #Get-EventLog -List | %{Get-EventLog -LogName $_.Log -After (Get-Date).AddMinutes(-1) -ErrorAction Ignore} | Sort-Object TimeGenerated | Format-Table -AutoSize -Wrap
    #$a= Get-WinEvent -FilterHashtable @{ LogName='System'; StartTime=$Date; Id='19';ProviderName='Microsoft-Windows-WindowsUpdateClient' } -ErrorAction Ignore
    $a= Get-WinEvent -FilterHashtable @{ LogName='System'; StartTime=$Date; ProviderName='Microsoft-Windows-WindowsUpdateClient'; Id='20' ; Level=2 } -ErrorAction Ignore
        if($a)
        {
        $Currentdateandtime= get-date
        write-host "$Currentdateandtime : Found the Error Event ID 20 and this script will start remediating through DISM"
        break;
        }
        else
        {
        $Currentdateandtime= get-date
        Write-Host "$Currentdateandtime : No Error event found for the past one minute"
        }

    }
}

MonitorEventlog