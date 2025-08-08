# Very slight mod to MS's script

# Define the time you want TAp to take affect
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$user = Read-Host "Enter the email for the user"

# Create a Temporary Access Pass for a user
$properties = @{}
$properties.isUsableOnce = $True
$properties.startDateTime = $time
$propertiesJSON = $properties | ConvertTo-Json

New-MgBetaUserAuthenticationTemporaryAccessPassMethod -UserID $user -BodyParameter $propertiesJSON