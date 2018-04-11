#Käesolev skript on paigaldatud Atea AS-i poolt lepinguliste raporteerimiskohustuste täitmiseks.
#Kontaktid
#E-mail: hooldus@atea.ee
#Telefon: +372 610 5924
#
#This script is put in place and maintained by Atea AS to fulfill obligations taken by contract.
#Contacts
#E-mail: service@atea.ee
#Phone: +372 610 5924

import-module ActiveDirectory

(Get-Culture).NumberFormat.NumberDecimalSeparator = '.'
$month = Get-Date -format Y
$SysAidCI = "sysaidIDnumber"
$usercount = (Get-ADGroupMember -Identity "grupinimiAD-s").count

$email = @{
    From = "from@aadress.ee"
    To = "to@aadress.ee"
    Subject = "Kliendi nimi user count, $month"
    SMTPServer = "SMTPserver"
    Body = "SysAidCI: $SysAidCI" + "`r`n" + "Count: $usercount"
    Encoding   = New-Object System.Text.UTF8Encoding
}

send-mailmessage @email
