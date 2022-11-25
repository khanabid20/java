<#

Setup:

	# Ref -> https://stackoverflow.com/a/70576201/9454903
	
	# Create Powershell profile to have the script loaded on a new powershell
	New-Item $profile -Type File -Force
	
	Copy the content of the script to --> C:\Users\{user_name}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile

	# Update the execution policy 
	# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force

Example:
	# Open a new powershell terminal as Administrator
	update_java_version 8 $True

Troubleshooting:
	Error #1:
		C:\Users\abikhan>java -version
		Registry key 'Software\JavaSoft\Java Runtime Environment\CurrentVersion'
		has value '1.8', but '1.6' is required.
		Error: could not find java.dll
		Error: could not find Java SE Runtime Environment.

	Resolution:

		https://stackoverflow.com/a/33755487/9454903
		To resolve this, remove all java.exe, javaw.exe and javaws.exe files on c:\ProgramData\Oracle\Java\javapath\ (C:\Program Files (x86)\Common Files\Oracle\Java\javapath-old)
		Remove java.exe, javaw.exe and javaws.exe from C:\Windows\System32
#>

function update_java_version($version, [bool] $everywhere)
{

    $java_value = (Get-Item Env:JAVA_HOME_${version}).value
    $jre_value = (Get-Item Env:JRE_HOME_${version}).value

    $Env:JAVA_HOME = $java_value
    $Env:JRE_HOME = $jre_value
	
    # Set System Environment Variable (need Administrative permission to run this)
    [System.Environment]::SetEnvironmentVariable("JAVA_HOME", $java_value, "Machine")
    [System.Environment]::SetEnvironmentVariable("JRE_HOME", $jre_value, "Machine")
    
    # Set User Environment Variable
    #[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $java_value, "User")
    #[System.Environment]::SetEnvironmentVariable("JRE_HOME", $jre_value, "User")
}
