param(
    [Parameter(Mandatory = $true)]
    [int]$RoomCapacity,

    [Parameter(Mandatory = $true)]
    [string]$RoomName,

    [Parameter(Mandatory = $true)]
    [string]$City,

    [Parameter(Mandatory = $true)]
    [string]$Office
)

# Create a safe alias / SMTP address (remove spaces)
$Alias = ($RoomName -replace '\s','')
$PrimarySmtp = "$Alias@example.com"

Write-Host "This may take a few minutes" -ForegroundColor Yellow

# Create room mailbox
New-Mailbox `
    -Name $Alias `
    -Alias $Alias `
    -Room `
    -DisplayName $RoomName `
    -PrimarySmtpAddress $PrimarySmtp

Start-Sleep -Seconds 35

Set-Place $Alias `
    -City $City `
    -CountryOrRegion "United States"

# Configure calendar processing
Set-CalendarProcessing $Alias `
    -AutomateProcessing AutoAccept `
    -BookingWindowInDays 365 `
    -AllBookInPolicy $true `
    -AllRequestInPolicy $false `
    -AllRequestOutOfPolicy $false

# Set room capacity
Set-Mailbox $Alias `
    -ResourceCapacity $RoomCapacity `
    -Office $Office