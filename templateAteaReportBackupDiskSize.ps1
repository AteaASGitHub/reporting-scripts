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
$SysAidCI = "ID number"
$used = Get-PSDrive E | Select-Object -ExpandProperty used
$result= $used / 1GB 
$resultfinal = [math]::Round($result,4)
$email = @{
    From = "from@aadress.ee"
    To = "to@aadress.ee"
    Subject = "Kliendi nimi backupi maht $m_y"
    SMTPServer = "SMTP server"
    Body = "SysAidCI: $SysAidCI" + "`r`n" + "Count: $resultfinal"
    Encoding   = New-Object System.Text.UTF8Encoding
}
send-mailmessage @email
