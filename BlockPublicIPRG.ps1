# The following PowerShell scipt is provided "as is" without any guarantees or warranty. 
# Although the author has attempted to find and correct any bugs in the script, the author is not responsible for any damage or losses of any kind caused by the use or misuse of this script. 
# The author is under no obligation to provide support, service, corrections, or upgrades to for this free script. 
# Script is intended to get an Azure resource group blocked from having a public ip deployed with PowerShell 
# Script written by Anthony de Lagarde from Microsoft July 3, 2018

# Applying an Azure Policy to block Public IP address from being deployed in a resource group



# Subscription selection
login-zurermaccount

# Setting Azure subscription to use
$subscription = "<enter in your subscription name here>"
Get-AzureRmSubscription -SubscriptionName $subscription | Set-AzureRmContext

Write-Host -ForegroundColor Yellow "$subscription subscription was selected!"
 
# Get the resource group to apply the policy against
$rgname = "<enter your resource group name here>"
$rg = Get-AzureRmResourceGroup -Name $rgname
 
# Create the policy definition
$definition = '{"if":{"anyOf":[{"source":"action","like":"Microsoft.Network/publicIPAddresses/*"}]},"then":{"effect":"deny"}}'
$policydef = New-AzureRmPolicyDefinition -Name NoPubIPPolicyDefinition -Description 'No public IP addresses allowed' -Policy $definition
 
# Assign the policy
New-AzureRmPolicyAssignment -Name NoPublicIPPolicyAllowed -PolicyDefinition $policydef -Scope $rg.ResourceId

Write-Host -ForegroundColor Yellow "Assigned NoPublicIPPolicyAllowed policy against resource group name $rgname"

Write-Host -ForegroundColor red "Please note it may take up to 30 minutes for this policy to take full effect!!!!!"`r
