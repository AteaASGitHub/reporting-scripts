#Käesolev skript on paigaldatud Atea AS-i poolt lepinguliste raporteerimiskohustuste täitmiseks.
#Kontaktid
#E-mail: hooldus@atea.ee
#Telefon: +372 610 5924
#
#This script is put in place and maintained by Atea AS to fulfill obligations taken by contract.
#Contacts
#E-mail: service@atea.ee
#Phone: +372 610 5924

(Get-Culture).NumberFormat.NumberDecimalSeparator = '.'

$m_y = Get-Date -format Y
$SysAidCI = "sysaidIDnumber"
$max = Get-Content "c:\scripts\AteaReportGroupCountUsers.txt" | Measure-Object -max -min -ave | Select-Object maximum,minimum,average
$email = @{
    From = "from@aadress.ee"
    To = "to@aadress.ee"
    Subject = "Kliendi nimi grupi nimi User count, $m_y"
    SMTPServer = "SMTPserver"
    Body = "SysAidCI: $SysAidCI" + "`r`n" + "Count: $max"
    Encoding = New-Object System.Text.UTF8Encoding
}

send-mailmessage @email
Clear-Content "c:\scripts\AteaReportGroupCountUsers.txt"
