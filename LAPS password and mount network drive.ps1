# Get LAPS Password and Mount c$
# 18.12.2019 mk

# Remove Netdrive
Remove-PSDrive X

# Setup
$Computer = 'HOSTNAME'
$LapsPasswordAttributeName = 'ms-Mcs-AdmPwd'

# Get LAPS Password from AD and convert to SecureString
$ADComputer = Get-ADComputer -Identity $Computer -Properties $LapsPasswordAttributeName
$LapsPassword = $ADComputer.$LapsPasswordAttributeName
$LapsPasswordSecure = $LapsPassword|ConvertTo-SecureString -AsPlainText -Force

# Display LAPS Password (Troubeshooting...)
clear
Write-Host 'Computer = ' $Computer
Write-Host 'Password = ' $LapsPassword

# Mount network drive with local Administrator
$Cred = New-Object System.Management.Automation.PsCredential('$Computer\Administrator',$LapsPasswordSecure)
New-PSDrive -Name X -PSProvider FileSystem -Root \\$Computer\C$ -Credential $Cred
