# Automated User Provisioning and Management in Microsoft 365 & Azure AD

This guide explains, in simple terms, how to use a PowerShell script and a CSV file to automate the setup and management of new users in a Microsoft 365 and Azure Active Directory environment. This process is perfect for IT administrators who want to save time, reduce manual errors, and ensure new team members are ready to work on day one.

---

## What Does This Process Do?

- **Creates new user accounts** in Microsoft 365/Azure AD using a simple spreadsheet (CSV file).
- **Assigns licenses and groups** so users have access to the right tools and permissions.
- **Sets up mailboxes** for email communication.
- **Prepares devices** for secure onboarding (with Intune or similar tools).
- **Checks compliance and security**, like whether users have multi-factor authentication (MFA) enabled.
- **Exports reports** so you can track user status and compliance.

---

## How It Works (Layman’s Terms)

1. **Prepare Your User List**
   - Fill out a spreadsheet (CSV file) with details for each new user: name, email, password, department, etc.
   - Example:
     ```
     DisplayName,UserPrincipalName,MailNickName,Password,Department,JobTitle
     John Doe,john.doe@yourdomain.com,johndoe,TempP@ssw0rd!,IT,IT Support Specialist
     ```

2. **Run the PowerShell Script**
   - The script reads your spreadsheet and automatically creates each user in Microsoft 365/Azure AD.
   - It sets up their email, assigns them to the right groups, and gives them the correct licenses.
   - The script can also enable security features like MFA and prepare devices for management.

3. **Automated Reporting**
   - The script checks who has been set up, who is missing security steps (like MFA), and exports this info to a report.
   - You can use these reports to make sure everyone is compliant and ready to go.

---

## Why Use This Process?

- **Saves Time:** No more manual data entry for each new user.
- **Reduces Errors:** Automates repetitive steps, so nothing gets missed.
- **Improves Security:** Ensures every user is set up with the right security from the start.
- **Easy to Track:** Generates reports so you always know the status of your users.

---

## What You Need

- Access to Microsoft 365 and Azure AD admin tools.
- PowerShell installed on your computer.
- The provided script and your filled-out CSV file.
- Appropriate admin permissions to create users and assign licenses.

---

## Example Use Cases

- Onboarding a new team or department.
- Migrating users from another system.
- Ensuring compliance and security for all users.

---

## Get Started

1. Download or copy the script.
2. Fill out your `newusers.csv` file with user details.
3. Open PowerShell as an administrator.
4. Run the script and follow any prompts.
5. Review the generated reports for compliance and follow up as needed.

---

**Questions?**  
Check out my [GitHub](https://github.com/clockpals1) for more scripts and automation tips, or reach out for help!

---
