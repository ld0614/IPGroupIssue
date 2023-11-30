New-AzResourceGroup -Name "IPGroupIssue" -Location "uksouth" -ErrorAction SilentlyContinue

#Initial Deployment works fine as deny settings are only applied at the end of the deployment
New-AzResourceGroupDeploymentStack -Name "IPGroupIssue-01" -ResourceGroupName "IPGroupIssue" -DenySettingsMode DenyWriteAndDelete -TemplateFile .\Deploy.bicep

#Rerun the deployment with no changes causes the IP Group to fail due to the update needed on the IP Group Object
Set-AzResourceGroupDeploymentStack -Name "IPGroupIssue-01" -ResourceGroupName "IPGroupIssue" -DenySettingsMode DenyWriteAndDelete -TemplateFile .\Deploy.bicep