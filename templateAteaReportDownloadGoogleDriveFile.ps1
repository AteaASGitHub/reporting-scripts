#Käesolev skript on paigaldatud Atea AS-i poolt lepinguliste raporteerimiskohustuste täitmiseks.
#Kontaktid
#E-mail: hooldus@atea.ee
#Telefon: +372 610 5924
#
#This script is put in place and maintained by Atea AS to fulfill obligations taken by contract.
#Contacts
#E-mail: service@atea.ee
#Phone: +372 610 5924

$now = Get-Date -format "dd-MM-yyyy HH.mm"
$OutFile = "SysAidi RDS path serveris\faili nimi $now.csv"

$refreshToken = "<refresh_token_HERE>"
$ClientID = "<CLIENT_ID_HERE>"
$ClientSecret = "<CLIENT_SECRET_HERE>"
$redirect_uri = "https://google.com" 
$grantType = "refresh_token" 
$requestUri = "https://accounts.google.com/o/oauth2/token" 
$Body = "refresh_token=$refreshToken&client_id=$ClientID&client_secret=$ClientSecret&grant_type=$grantType" 
$response = Invoke-RestMethod -Method Post -Uri $requestUri -ContentType "application/x-www-form-urlencoded" -Body $Body 

$accessToken = $response.access_token
$FileID = "<Google file FILE_ID_HERE>"

$headers = @{"Authorization" = "Bearer $accessToken"          
              "Content-type" = "application/json"}
$restCall = Invoke-RestMethod `
-Uri "https://www.googleapis.com/drive/v3/files/$FileID/export?mimeType=text/csv" `
-Method Get `
-Headers $headers `
-outfile "C:\Apps\GoogleZapierSysAidCICount $now.csv"
