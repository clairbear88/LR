Start-Process Outlook

$o = New-Object -com Outlook.Application

 
$mail = $o.CreateItem(0)

#2 = high importance email header
#$mail.importance = 2

$mail.subject = "REMINDER: Mayo Weekly Tasks"

$mail.body = @“
This is an automated reminder to ensure the following tasks are completed by COB:

    -All Tasks are created and updated
    -All Work logs are entered and up to date
    -All Support Tickets are up to date
    -Q, please hand-off or send out weekly volume stats for weekly status report
    -On-Site Consultant please send out a brief list of this week’s Highlights

Please let me know if you need anything?

Thanks,
-James

“@

#for multiple email, use semi-colon ; to separate
$mail.To = “project74@logrhythm.com“

$mail.Send()

# $o.Quit()