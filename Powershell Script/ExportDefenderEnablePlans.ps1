#########################################################################
# This content is licensed over the Creative Commons                    #
# https://creativecommons.org/publicdomain/zero/1.0/?ref=chooser-v1     #
# This script were created by Edson Matias Fagundes Junior              # 
#########################################################################
# The script have as objective export the Defender for cloud plans      # 
#########################################################################

Connect-AZAccount  

$ErrorActionPreference =  "Stop"  
try  {  
Get-AzSubscription | 
#Where-Object Name -like "*DEV*"|
ForEach-Object {
    $subscriptionName = $_.Name
    Set-AzContext  -SubscriptionName  $_.Name 
    Get-AzSecurityPricing | select Name, PricingTier, FreeTrialRemainingTime,Id |  Export-Csv  .\AzureDefender.csv -Append  -Force  -NoTypeInformation  
  }
}  

catch  {  
    Write-Host  "$($_.Exception.Message)"  -BackgroundColor  DarkRed  
}