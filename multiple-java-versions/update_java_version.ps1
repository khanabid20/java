'''
Example: 
	update_java_version 8 $True
'''

function update_java_version($version, [bool] $everywhere)
{

    $java_value = (Get-Item Env:JAVA_HOME_${version}).value
    $jre_value = (Get-Item Env:JRE_HOME_${version}).value
    $Env:JAVA_HOME = $java_value
    $Env:JRE_HOME = $jre_value
    refresh-path

    if ($everywhere)
    {
        [System.Environment]::SetEnvironmentVariable("JAVA_HOME", $java_value, "User")
        [System.Environment]::SetEnvironmentVariable("JRE_HOME", $jre_value, "User")
    }
}

function refresh-path
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") +
            ";" +
            [System.Environment]::GetEnvironmentVariable("Path", "User")
}


'''
# Ref -> https://stackoverflow.com/a/70576201/9454903

New-Item $profile -Type File -Force

Copy the content of the script to --> C:\Users\{user_name}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile

# Update the execution policy 

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force

'''
