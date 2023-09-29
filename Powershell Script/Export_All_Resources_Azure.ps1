

#########################################################################
# This content is licensed over the Creative Commons                    #
# https://creativecommons.org/publicdomain/zero/1.0/?ref=chooser-v1     #
# This script were created by Edson Matias Fagundes Junior              #
# using Hari Krishna - Partial code :D                                  #
#########################################################################

# https://stackoverflow.com/questions/69962836/how-to-get-list-of-all-azure-subscriptions-and-resources-using-powershell-in-sp

#########################################################################
#The script have as objective export all resources on all subscriptions.#
#########################################################################


Connect-AZAccount  

$ErrorActionPreference =  "Stop"  
try  {  
Get-AzSubscription | 
#Where-Object Name -like "*DEV*"|
#In case you would like to filter the Subscriptions you can use the preview line, removing the comment. 

ForEach-Object {
    $subscriptionName = $_.Name
    Set-AzContext  -SubscriptionName  $_.Name 
    $rgs =  Get-AzResourceGroup  
    foreach  ($rg in $rgs.ResourceGroupName)  
    {  
    Write-Output  "Checking Resource Group: $rg"  
    Get-AzResource -ResourceGroupName $rg |  Select  Name,  ResourceGroupName,  Type,  Location, ResourceId  |  Export-Csv  .\AzureResources.csv -Append  -Force  -NoTypeInformation  
    }  
  }
}  

catch  {  
    Write-Host  "$($_.Exception.Message)"  -BackgroundColor  DarkRed  
}

Get-AzSubscription | select id, Name, TenantId, State | Export-Csv  .\AzureSubscription.csv -Force  -NoTypeInformation
