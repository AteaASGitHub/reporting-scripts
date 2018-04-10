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

$vCenterName = "vCenter_server_name"

#https://www.pdq.com/blog/secure-password-with-powershell-encrypting-credentials-part-2/
#Kui konto parool muutub, siis tuleb uued failid luua. Vt. skripte
#Atea_Report_Creating AES key with random data and export to file.ps1
#Atea_Report_Creating SecureString object.ps1
#Atea_Report_Creating PSCredential object.ps1

Connect-VIServer $vCenterName -Credential (Import-clixml "useraccount.clixml")


$month = Get-Date -format Y

$smtp = "smtp_server"
$from_address = "from@aadress.ee"
$to_address = "to@aadress.ee"

#Raporteeritavate servite nimekirja faili esimene rida peab olema päisena (header) kujul
#"Server_name", "SysAidCI_vCPU", "SysAidCI_vRAM", "SysAidCI_HDD"
#järgmised read päris serverid
$InFile = "Atea_Report_vCenter_VM_vCPU_vRAM_HDD_server_list.txt"
$VirtualMachines = import-csv $InFile

function NumberOfCPUs {
    Param ([string]$vmName, [string]$SysAidCI)
    $vms = Get-View -ViewType VirtualMachine
    $vm = $vms | Where-Object {$_.Name -Match $vmName}
    $Count = [math]::round($vm.Config.Hardware.NumCPU, 4)
    $email_CPUs = @{
        From = $from_address
        To = $to_address
        Subject = "$vmName number of vCPUs $month"
        SMTPServer = $smtp
        Body = "SysAidCI: $SysAidCI" + "`r`n" + "Count: $Count"
        Encoding   = New-Object System.Text.UTF8Encoding
    }
    send-mailmessage @email_CPUs
}

function NumberOfRAM {
    Param ([string]$vmName, [string]$SysAidCI)
    $vms = Get-VM
    $vm = $vms | Where-Object {$_.Name -Match $vmName}
    $Count = [math]::round($vm.MemoryGB, 4)
    $email_RAM = @{
        From = $from_address
        To = $to_address
        Subject = "$vmName number of vRAM $month"
        SMTPServer = $smtp
        Body = "SysAidCI: $SysAidCI" + "`r`n" + "Count: $Count"
        Encoding   = New-Object System.Text.UTF8Encoding
    }
    send-mailmessage @email_RAM
}

function NumberOfProvisionedSpace {
    Param ([string]$vmName, [string]$SysAidCI)
    $vms = Get-VM
    $vm = $vms | Where-Object {$_.Name -Match $vmName}
    $Count = [math]::round($vm.ProvisionedSpaceGB, 4)
    $email_HDD = @{
        From = $from_address
        To = $to_address
        Subject = "$vmName number of HDD $month"
        SMTPServer = $smtp
        Body = "SysAidCI: $SysAidCI" + "`r`n" + "Count: $Count"
        Encoding   = New-Object System.Text.UTF8Encoding
    }
    send-mailmessage @email_HDD
}




foreach ($element in $VirtualMachines) {
    NumberOfCPUs $element.Server_name $element.SysAidCI_vCPU
    NumberOfRAM $element.Server_name $element.SysAidCI_vRAM
    NumberOfProvisionedSpace $element.Server_name $element.SysAidCI_HDD
}

