##* '###########################################################################
##* ' 28.06.2016 mk
##* ' 25.07.2016 mk ; added last exec timestamp & convert to powershell
##* ' 11.12.2019 mk ; new fileserver
##* '###########################################################################

$path = "D:\Data\Transfer"
$logfile = "C:\Scripts\clear_transfer.log"
$limit = (Get-Date).AddDays(-15)
$lastrun = Get-Date

# Write log file
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Out-File $logfile

# Remove thumbs.db
Get-ChildItem -Path $path -Include Thumbs.db -Recurse -Name -Force | Remove-Item -Force

# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force

# Delete any empty directories left behind after deleting the old files.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse

# Write Note
Add-Content -path "$path\_important.txt" -value "Files in this folder that are older than 14 days will be deleted automatically."
Add-Content -path "$path\_important.txt" -value "last script execution: $lastrun"	
