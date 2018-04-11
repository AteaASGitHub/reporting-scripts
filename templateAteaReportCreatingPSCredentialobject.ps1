$User = "kasutajakonto"
$PasswordFile = "Atea_Report_vCenter_VM_vCPU_vRAM_HDD_Password.txt"
$KeyFile = "Atea_Report_vCenter_VM_vCPU_vRAM_HDD_AES.key"
$key = Get-Content $KeyFile
$Credential = New-Object -TypeName System.Management.Automation.PSCredential `
 -ArgumentList $User, (Get-Content $PasswordFile | ConvertTo-SecureString -Key $key)
