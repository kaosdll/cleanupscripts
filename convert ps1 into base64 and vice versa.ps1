$command= [System.IO.File]::ReadAllText("C:\temp\Test.ps1")            
$bytes= [System.Text.Encoding]::Unicode.GetBytes($command)            
$encodedCommand = [System.Convert]::ToBase64String($bytes)            
$encodedCommand            
            
powershell.exe –EncodedCommand $encodedCommand            
            
powershell.exe -EncodedCommand VwByAGkAdABlAC0ASABvAHMAdAAgACIAQgBhAHMAZQA2ADQAIABaAGUAaQBjAGgAZQBuAGsAZQB0AHQAZQAiAA==            
            
[System.Text.Encoding]::Unicode.GetString(([System.Convert]::FromBase64String($encodedCommand )))
