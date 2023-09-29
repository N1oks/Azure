#########################################################################
# This content is licensed over the Creative Commons                    #
# https://creativecommons.org/publicdomain/zero/1.0/?ref=chooser-v1     #
# This script were created by Edson Fagundes                            # 
#########################################################################
# The script have as objective export the OS version of all AKS pool.   # 
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
    foreach  ($rg in $rgs.ResourceGroupName){ 
        if(Get-AzAksCluster){
             $Cluster = Get-AzAksCluster
             if($cluster.Name){
                foreach($unicName in $cluster){
                    Get-AzAksNodePool -ResourceGroupName $unicName.ResourceGroupName  -ClusterName $unicName.Name |  Select  Id, OsType,  OsSKU, OrchestratorVersion, CurrentOrchestratorVersion  |  Export-Csv  .\ContainerOS.csv -Append  -Force  -NoTypeInformation  
                }
            
            }
        }
        
    }  
  }
}  

catch  {  
    Write-Host  "$($_.Exception.Message)"  -BackgroundColor  DarkRed  
}

     
