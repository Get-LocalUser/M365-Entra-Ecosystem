$Rooms = @()

foreach ($Room in $Rooms) {
    Get-CalendarProcessing -Identity $Room | Select-Object `
        Identity, `
        AutomateProcessing, `
        ResourceDelegates, `
        AllBookInPolicy, `
        AllRequestInPolicy, `
        AllRequestOutofPolicy, `
        ForwardRequestsToDelegates
}