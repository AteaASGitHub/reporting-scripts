
#Käesolev skript on paigaldatud Atea AS-i poolt lepinguliste raporteerimiskohustuste täitmiseks.
#Kontaktid
#E-mail: hooldus@atea.ee
#Telefon: +372 610 5924
#
#This script is put in place and maintained by Atea AS to fulfill obligations taken by contract.
#Contacts
#E-mail: service@atea.ee
#Phone: +372 610 5924

$user = "miradore'i kasutajakonto"
$pass = "miradore'i kasutajakonto parool"
$pair = "${user}:${pass}"

(Get-Culture).NumberFormat.NumberDecimalSeparator = '.'
$m_y = Get-Date -format Y
$smtp = "SMTP server"
$from_address = "from@aadress.ee"
$to_address = "to@aadress.ee"

$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)

$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }

#Raporteeritavate nimekirja faili esimene rida peab olema päisena (header) kujul.
#"Company", "SysAidCI", "Web_service_URL"
#järgmised read päris raportite URL-id.
#Soovitatavalt salvestada fail UTF-8 kodeeringus.
$InFile = "Atea_Report_Miradore_reports_list.txt"
$Reports = import-csv $InFile -Encoding UTF8



function Count_of_licenses {
    Param ([string]$Client, [string]$SysAidCI, [string]$Report_URL)
    $WebResponse = Invoke-WebRequest -Uri $Report_URL -Headers $headers
    $Count = ([xml]$WebResponse.Content).Response.Items.count

    $email = @{
        From = $from_address
        To = $to_address
        Subject = "$Client number of assets requiring license, $m_y"
        SMTPServer = $smtp
        Body = "SysAidCI: $SysAidCI" + "`r`n" + "Count: $Count"
        Encoding   = New-Object System.Text.UTF8Encoding
    }
    send-mailmessage @email
}


foreach ($element in $Reports) {
	Count_of_licenses $element.Company $element.SysAidCI $element.Web_service_URL
}

