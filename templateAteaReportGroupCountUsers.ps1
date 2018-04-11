#Käesolev skript on paigaldatud Atea AS-i poolt lepinguliste raporteerimiskohustuste täitmiseks.
#Kontaktid
#E-mail: hooldus@atea.ee
#Telefon: +372 610 5924
#
#This script is put in place and maintained by Atea AS to fulfill obligations taken by contract.
#Contacts
#E-mail: service@atea.ee
#Phone: +372 610 5924

$group = Get-ADGroup -identity "grupinimiAD-s"
$countUser = (Get-ADGroupMember $group.DistinguishedName).count 
add-content "c:\scripts\AteaReportGroupCountUsers.txt" $countUser

