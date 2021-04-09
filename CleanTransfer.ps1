###########################################################################################
### Cleanup Script # 08.04.2021 # kussma
###########################################################################################
### Setup
###########################################################################################
$log="D:\CleanTransferScript\CleanTransfer.log" # logfile location
$days="-6" # files to delete current date minus $days
$timestamp="LastWriteTime" # relevant time stamp: CreationTime ; LastAccessTime ; LastWriteTime
$del="no" # set to 'yes' to disable test mode (delte files)

###########################################################################################
### Functions
###########################################################################################
function Log-Message
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$LogMessage
    )
    Write-Output ("{0} - {1}" -f (Get-Date), $LogMessage) | Out-File -FilePath "$log" -Append
}

function Clean-FilesInFolder
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Folder
    )
    Get-ChildItem -Path "$Folder" -Recurse -File | Where $timestamp -lt (Get-Date).AddDays($days) | Out-File -FilePath "$log" -Append
    if($del -eq "yes") { Get-ChildItem -Path "$Folder" -Recurse -File | Where $timestamp -lt (Get-Date).AddDays($days) | Remove-Item -Recurse -Force }
   
}

function Clean-Folder
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Folder
    )
        # cleanup files
        Get-ChildItem -Path "$Folder" -Recurse -File | Where $timestamp -lt (Get-Date).AddDays($days) | Out-File -FilePath "$log" -Append # log
        if($del -eq "yes") { Get-ChildItem -Path "$Folder" -Recurse -File | Where $timestamp -lt (Get-Date).AddDays($days) | Remove-Item -Recurse -Force } # delete files
        # cleanup empty folders
        if($del -eq "yes") {
            do {
                $dirs = gci $Folder -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName
                $dirs | Foreach-Object { Remove-Item $_ }
            } while ($dirs.count -gt 0)  
        }
}

###########################################################################################
### Action
###########################################################################################

Remove-Item -Path "$log" # remove log
if ($del -ne "yes") { Log-Message "TEST MODE - NO FILES WILL BE DELETED" } # write info
Log-Message "Script Started" # log script start

#    Clean-Folder "D:\Export\Transfer_MM\xxx"
    Clean-Folder "D:\Export\Transfer_MM\yyy"


Log-Message "Script Ended" # log script end
if ($del -ne "yes") { Log-Message "TEST MODE - NO FILES WILL BE DELETED" } # write info
