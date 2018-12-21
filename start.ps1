param(
    
    [Parameter(Mandatory = $false)]
    [string]$sa_password,

    [Parameter(Mandatory = $false)]
    [string]$ACCEPT_EULA,

    [Parameter(Mandatory = $false)]
    [string]$attach_dbs,
    
    [Parameter(Mandatory = $true)]
    [string]$ssrs_user,

    [Parameter(Mandatory = $true)]
    [string]$ssrs_password
    
)

    
.\sqlstart -sa_password $sa_password -ACCEPT_EULA $ACCEPT_EULA -attach_dbs \"$attach_dbs\" -Verbose


Write-Verbose "SSRS Config"
.\configureSSRS2017 -Verbose

.\newadmin -username $ssrs_user -password $ssrs_password -Verbose

$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) { 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
   
    $lastCheck = Get-Date
    Start-Sleep -Seconds 2 
}
