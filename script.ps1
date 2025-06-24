# Import required modules
Import-Module AzureAD
Import-Module MSOnline
Import-Module ExchangeOnlineManagement

# Connect to Azure services
Connect-AzureAD
Connect-MsolService
Connect-ExchangeOnline -UserPrincipalName admin@yourdomain.com

# 1. User Provisioning from CSV
$users = Import-Csv -Path "C:\Scripts\newusers.csv"
foreach ($user in $users) {
    # Create user in Azure AD
    $aadUser = New-AzureADUser -DisplayName $user.DisplayName `
        -UserPrincipalName $user.UserPrincipalName `
        -AccountEnabled $true `
        -MailNickName $user.MailNickName `
        -PasswordProfile (New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile -Property @{Password = $user.Password; ForceChangePasswordNextLogin = $true})

    # Assign license
    Set-MsolUserLicense -UserPrincipalName $user.UserPrincipalName -AddLicenses "yourtenant:ENTERPRISEPACK"

    # Add to security group(s)
    Add-AzureADGroupMember -ObjectId "group-object-id" -RefObjectId $aadUser.ObjectId

    # Enable MFA (if not default policy)
    Set-MsolUser -UserPrincipalName $user.UserPrincipalName -StrongAuthenticationRequirements @(@{RelyingParty="*"; State="Enabled"})
}

# 2. Mailbox Management
foreach ($user in $users) {
    Enable-Mailbox -Identity $user.UserPrincipalName
    # Optional: Set mailbox size limits, policies, etc.
    Set-Mailbox -Identity $user.UserPrincipalName -IssueWarningQuota 1.5GB -ProhibitSendQuota 2GB
}

# 3. Device Onboarding (Intune Enrollment)
# Note: Intune device onboarding is typically user-driven, but you can automate assignment of policies and apps
foreach ($user in $users) {
    # Assign Intune device compliance policy
    # Example: Assign policy by group membership or script
    # (Requires Intune PowerShell SDK and further customization)
}

# 4. Compliance Reporting
# Export list of users and compliance status
$compliance = Get-AzureADUser | Select DisplayName, UserPrincipalName, AccountEnabled
$compliance | Export-Csv -Path "C:\Scripts\user_compliance_report.csv" -NoTypeInformation

# List users without MFA enabled
$noMFA = Get-MsolUser | Where-Object { $_.StrongAuthenticationRequirements.Count -eq 0 }
$noMFA | Select DisplayName, UserPrincipalName | Export-Csv -Path "C:\Scripts\users_without_MFA.csv" -NoTypeInformation

# Disconnect from services
Disconnect-ExchangeOnline -Confirm:$false
