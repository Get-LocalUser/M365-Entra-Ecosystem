# This script creates a new room resource mailbox in Exchange Online.

param(
    [Parameter(Mandatory = $true)]
    [int]$RoomCapacity,

    [Parameter(Mandatory = $true)]
    [string]$RoomName
)

New-Mailbox `
    -Name $RoomName `
    -Room `
    -DisplayName $RoomName `
    -PrimarySmtpAddress "$RoomName@example.com"

Set-CalendarProcessing $RoomName `
    -AutomateProcessing AutoAccept `
    -BookingWindowInDays 365

Set-Mailbox $RoomName `
    -ResourceCapacity $RoomCapacity