#Käesolev skript on paigaldatud Atea AS-i poolt lepinguliste raporteerimiskohustuste täitmiseks.
#Kontaktid
#E-mail: hooldus@atea.ee
#Telefon: +372 610 5924
#
#This script is put in place and maintained by Atea AS to fulfill obligations taken by contract.
#Contacts
#E-mail: service@atea.ee
#Phone: +372 610 5924

$month = Get-Date -format Y
$SysAidCI_asutused1 = 0000
$max_asutused1 = Get-Content "c:\scripts\template_Atea_Report_Exch_Mailbox_Count_asutused1.txt.txt" | Measure-Object -max -min -ave | Select-Object maximum,minimum,average
$email_asutused1 = @{
From = "from@aadress.ee"
To = "to@aadress.ee"
Subject = "Mailbox Enabled Users Count asutused1 $month"
SMTPServer = "smtp_serveri_aadress"
Body = "SysAidCI: $SysAidCI_asutused1" + "`r`n" + "Count: $max_asutused1"
}
send-mailmessage @email_asutused1
Clear-Content "c:\scripts\template_Atea_Report_Exch_Mailbox_Count_asutused1.txt.txt" 

$SysAidCI_asutused3 = 0001
$max_asutused3 = Get-Content "c:\scripts\template_Atea_Report_Exch_Mailbox_Count_asutused3.txt" | Measure-Object -max -min -ave | Select-Object maximum,minimum,average
$email_asutused3 = @{
From = "from@aadress.ee"
To = "to@aadress.ee"
Subject = "Mailbox Enabled Users Count asutused3 $month"
SMTPServer = "smtp_serverid_aadress"
Body = "SysAidCI: $SysAidCI_asutused3" + "`r`n" + "Count: $max_asutused3"
}
send-mailmessage @email_asutused3
Clear-Content "c:\scripts\template_Atea_Report_Exch_Mailbox_Count_asutused3.txt.txt"
