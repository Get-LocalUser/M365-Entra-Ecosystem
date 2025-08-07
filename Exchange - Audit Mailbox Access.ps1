<#
.SYNOPSIS
    Shows which mailboxes a user has access to in Exchange Online.

.NOTES
    - Requires ExchangeOnlineManagement module (auto-installs if missing).
#>

if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
    Write-Host "Module not found. Installing ExchangeOnlineManagement..." -ForegroundColor Yellow
    Install-Module -Name ExchangeOnlineManagement
}

Import-Module ExchangeOnlineManagement -ErrorAction Stop

$admin = Read-Host "Enter your admin account (e.g., john.doe@example.com)"
$user = Read-Host "Enter the user's account name (e.g., john.doe)"

Connect-ExchangeOnline -UserPrincipalName $admin -ShowBanner:$false
Get-Mailbox -ResultSize Unlimited | Get-MailboxPermission -User $user | Format-Table User, Identity, AccessRights