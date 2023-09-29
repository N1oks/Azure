#########################################################################
# This content is licensed over the Creative Commons                    #
# https://creativecommons.org/publicdomain/zero/1.0/?ref=chooser-v1     #
# This script were created by Edson Matias Fagundes Junior              # 
#########################################################################
# The script have as objective export the OS version of VMs.            # 
#########################################################################

Connect-AZAccount 

Get-AzSubscription | 
#Where-Object Name -like "*DEV*"|
#In case you would like to filter the Subscriptions you can use the preview line, removing the comment. 

ForEach-Object {
    $subscriptionName = $_.Name
    echo $subscriptionName
    $result = az vm list --subscription $subscriptionName --query "[].[name,storageProfile.imageReference.offer,storageProfile.imageReference.sku]" 
    $json = $result | ConvertFrom-Json

    $json | % {
        $item = New-Object PSCustomObject
        $item | Add-Member -NotePropertyName "vmName" -NotePropertyValue $_.SyncRoot[0]
        $item | Add-Member -NotePropertyName "Os" -NotePropertyValue $_.SyncRoot[1]
        $item | Add-Member -NotePropertyName "sku" -NotePropertyValue $_.SyncRoot[2]

        $item | Export-Csv .\servers.csv  -NoTypeInformation  -Append
    }

}
  

