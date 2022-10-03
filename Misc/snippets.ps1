# Send authenticated smtp email
$cred = Get-Credential
Send-MailMessage -From me@company.org -To joe@gmail.com -Subject 'this is a subject' -Body 'this is the body' -smtpserver smtp.office365.com -UseSsl -Port 587 -Credential $cred