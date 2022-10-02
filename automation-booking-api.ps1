
$Username="ServerAdmin"
$Password="HARDpassword1"
$SqlServerPassword=New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username,(ConvertTo-SecureString -String $Password -AsPlainText -Force)
New-AzAppServicePlan -ResourceGroupName "session21" -Name "booking-api-plan" -Tier "Basic" -NumberofWorkers 2 -WorkerSize "Small" -Location "westeurope"
New-AzWebApp -ResourceGroupName "session21" -AppServicePlan "booking-api-plan" -Name "booking-api-webapp" -ContainerImageName "mbidzinsk/booking-api:latest" -ContainerRegistryUser "mbidzinsk" -Location "westeurope" -ContainerRegistryUrl  "mbidzinsk/booking-api:latest"
New-AzSqlServer -Location "westeurope" -ResourceGroupName "session21" -ServerName "mbidzinsksqlserver" -SqlAdministratorCredentials $SqlServerPassword
New-AzSqlDatabase -ResourceGroupName "session21" -DatabaseName "mbidiznssqldatabase" -ServerName "mbidzinsksqlserver"
Set-AzWebApp -ConnectionStrings @{ MyConnectionString = @{ Type="SQLAzure"; Value ="Server=tcp:mbidzinsksqlserver.database.windows.net;Database=mbidiznssqldatabase;User ID=$Username@$mbidzinsksqlserver;Password=$Password;Trusted_Connection=False;Encrypt=True;" } } -Name "booking-api-webapp" -ResourceGroupName "session21"