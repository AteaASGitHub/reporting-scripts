$PasswordFile = "Atea_Report_vCenter_VM_vCPU_vRAM_HDD_Password.txt"
$KeyFile = "Atea_Report_vCenter_VM_vCPU_vRAM_HDD_AES.key"
$Key = Get-Content $KeyFile
$Password = "keerulineAb0#parool" | ConvertTo-SecureString -AsPlainText -Force
$Password | ConvertFrom-SecureString -key $Key | Out-File $PasswordFile