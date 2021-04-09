# Add all from users.csv to AD group

Import-module ActiveDirectory  
$List = Import-CSV "C:\Ins\users.csv"
ForEach ($User in $List)
{
Add-ADGroupMember -Identity "ADGROUPNAME" -Member $User.username
}
