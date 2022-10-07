$ResourceGroupName = "tfstate"
New-AzResourceGroupDeployment `
    -Name "nginx-app-service" `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile 'nginx-app-service.json' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "nginx-file-share" `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile 'nginx-storage-file.json' `
    -Verbose