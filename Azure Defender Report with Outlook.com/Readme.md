# Identifying Subscriptions that are not Managed by Microsoft Defender for Cloud
**Author of the original code: Safeena Begum**
**Author of the change code: Edson Matias Fagundes Junior**

This is a script originaly created by Safeena Begum, and customized and upgraded by me for learning propose and without any financial interest, you can use this free code to if you need withou any financial interested. 

The proposal of this code is fix some of the issues that i face during the deployment of the original report that you can find on this link https://github.com/Azure/Microsoft-Defender-for-Cloud/tree/main/Workflow%20automation/SubscriptionManagement.

## Those are the issues, that I tried to fix for my needs:
    Not working  if you dont have O365 services enable
    Not working for Childrens of Management group just root.

## Prerequisites:

a. Create a resource group

a1. Create User Assigned Managed Identity. Follow the instructions listed in the doc to [create user-assigned managed identity](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/how-to-manage-ua-identity-portal#create-a-user-assigned-managed-identity)

b. Once User-assgined managed identity is created, make sure to provide Reader Permissions to the Root Management Group
    b.1 On this step I had some issues that by default you dont have that permission and you need to elevate your permission to add the Managed identity permisson on Management group Root Level, remeber its important to be on Root Level. [Elevate Access Global Admin] (https://learn.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin)
    b.2 In my case for test propose, I create one account that I used to authorize the ARM api and for that account I use the   Azure role assignments to assing the Logic App Operator that is needed.
    ![Alt text](image.png) 

c. Enable and add the above created User assigned Identity to the Logic App. Follow the instructions [here](https://docs.microsoft.com/en-us/azure/logic-apps/create-managed-service-identity#create-user-assigned-identity-in-the-azure-portal) to assign the User assigned identity to the Logic App. 

## How it works: 
By default this automation runs weekly and queries the Root Management group to identify any new subscription(s) that are directly assigned to the root management group. 
If one or more subscriptions are found in the Root management group, the Logic App will send an email with the following details: Subscription Name, Subscription ID, Action, Status of the subscription (If MDC is enabled or disabled). Image 1 has an example of how this email look like:
Make sure to add the subscription(s) to the Management Groups in order to start monitoring using Microsoft Defender for Cloud.
The automation artifact also creates a Storage account with a table storage in it during the deployment of the template. If the intent of assigning the subscription to the root management group was on purpose, you could exclude the subscription from being displayed in the email on next run by just clicking on the hyperlink ‘Exclude <subscriptionname>’ under the Action column of Image 1. 
In the next run (weekly) it will not display the subscriptions you added to the Exclusion list (table storage) and notifies only newly added subscription(s) via email. 

![](https://github.com/Azure/Azure-Security-Center/blob/master/Workflow%20automation/SubscriptionManagement/Images/ExampleEmailOutput.PNG)
***

You can deploy the main template by clicking on the buttons below:

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Security-Center%2Fmaster%2FWorkflow%2520automation%2FSubscriptionManagement%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Security-Center%2Fmaster%2FWorkflow%2520automation%2FSubscriptionManagement%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a> 

***
Check out this [blog](https://techcommunity.microsoft.com/t5/azure-security-center/identifying-subscriptions-that-are-not-managed-by-azure-security/ba-p/2111408) to understand more about the automation and for step by step instructions. 

# Acknowledgements
Thanks to Nicholas DiCola & Gilad Elyashar for this wonderful automation idea. <br>
