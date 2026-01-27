$admin = Read-Host "Enter your admin account (e.g., john.doe@example.com)"
$user = Read-Host "Enter the user's account name (e.g., john.doe)"

Connect-ExchangeOnline -UserPrincipalName $admin -ShowBanner:$false
Get-EXOMailbox -ResultSize Unlimited | Get-EXOMailboxFolderPermission -User $user | Format-Table User, Identity, AccessRights