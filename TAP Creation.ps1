# Very slight mod to MS's script

# Connect to Graph
$context = Get-MgContext 
if ($null -ne $context -and $context.Scopes -contains "UserAuthenticationMethod.ReadWrite.All") {
} else {
    Connect-MgGraph -Scopes "UserAuthenticationMethod.ReadWrite.All" -NoWelcome
}

# Define the time you want TAp to take affect
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$user = Read-Host "Enter the email for the user"

# Create a Temporary Access Pass for a user
$properties = @{}
$properties.isUsableOnce = $false
$properties.startDateTime = $time
$propertiesJSON = $properties | ConvertTo-Json

New-MgBetaUserAuthenticationTemporaryAccessPassMethod -UserID $user -BodyParameter $propertiesJSON

try {
    $question = Read-Host "Do you want to remove the current TAP?"
    if ($question -eq "y") {
        Remove-MgBetaUserAuthenticationTemporaryAccessPassMethod -UserId $user
    } else {
        Write-Host "You said no. TAP remains"
    }
}
catch {
    Write-Host "Failed to remove TAP. Manually remove from the Entra Admin Center" -ForegroundColor Red
    "Error: $($_.Exception.Message)"
}