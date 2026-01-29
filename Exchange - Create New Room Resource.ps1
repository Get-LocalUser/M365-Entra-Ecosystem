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
    -AutomateProcessing AutoAccept ` # Automatically accept meeting requests as long as no policy says otherwise.
    -BookingWindowInDays 365 ` # How many days in advance you can book the room.
    -AllBookInPolicy $False ` # Not everyone can autobook. Only users allowed explicity in the 'BookinPolicy'.
    -AllRequestInPolicy $True ` # Anyone in the org can request the room but may need delegate approval if setup. If $false, only people in the BookInPolicy can request. if not, it'll be auto denied.
    -AllRequestOutOfPolicy $False # users who are out of policy cannot request the room.

Set-Mailbox $RoomName `
    -ResourceCapacity $RoomCapacity # Number of people the room can hold