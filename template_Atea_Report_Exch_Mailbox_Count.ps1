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

Add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010

$asutused1=(Get-Recipient -ResultSize Unlimited -RecipientType UserMailbox -OrganizationalUnit "OU=Asutused1,OU=Koik_asutused,DC=domeen,DC=local").count
$asutused2=(Get-Recipient -ResultSize Unlimited -RecipientType UserMailbox -OrganizationalUnit "OU=Asutused2,OU=Koik_asutused,DC=domeen,DC=local").count
$asutused3=(Get-Recipient -ResultSize Unlimited -RecipientType UserMailbox -OrganizationalUnit "OU=Asutused3,OU=Koik_asutused,DC=domeen,DC=local").count
$asutused4=(Get-Recipient -ResultSize Unlimited -RecipientType UserMailbox -OrganizationalUnit "OU=Asutused4,OU=Koik_asutused,DC=domeen,DC=local").count
$result_asutused1=$asutused1+$asutused2+$asutused4
add-content "c:\scripts\template_Atea_Report_Exch_Mailbox_Count_asutused1.txt" $result_asutused1
add-content "c:\scripts\template_Atea_Report_Exch_Mailbox_Count_asutused3.txt" $asutused3