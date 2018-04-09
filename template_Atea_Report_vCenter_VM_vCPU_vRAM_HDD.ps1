(Get-Culture).NumberFormat.NumberDecimalSeparator = '.'

$vCenterName = "servername"
Connect-VIServer $vCenterName -Credential (Import-clixml "useraccount.clixml")


$month = Get-Date -format Y

$smtp = "smtp_server"
$from_address = "from@aadress.ee"
$to_address = "to@aadress.ee"

#Raporteeritavate serite nimekirja faili esimene rida peab olema päisena (header) kujul
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

