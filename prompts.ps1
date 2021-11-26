#Joshua Taylor Student ID: 001322591

$mynum = 0

#A function to retrieve the log files and pipe to a new out file.
Function DailyLogFiles {
	Param(
		[string]$myfilepath = "$PSScriptRoot\Requirements1"
	)
	#Listing the log files within the Requirements1 folder
	$logs = (Get-ChildItem $myfilepath | Where-Object name -like *.log)
	#Redirecting the log file results to a daily log txt file
	"The log file has been created" + (Get-Date) | Out-File -Append -FilePath $PSScriptRoot\DailyLog.txt
	$logs | Out-File -Append $PSScriptRoot\DailyLog.txt
	}
#Listing the files in tabular format
Function ListFiles {
	Param(
		[string]$myfilepath = "$PSScriptRoot\Requirements1"
	)
    #This will list the files in tabular format and pipe it to a new file
	$logs = Get-ChildItem $myfilepath | Sort-Object Name -descending | Format-Table
	$logs | Out-File $PSScriptRoot\C916contents.txt	
	
}
#Creating a switch statement that prompts the user after the completion of each task.
Try 
{
	while ( $mynum -ne 5)
	{ 
		write-host -ForegroundColor White 
		$mynum = Read-Host -Prompt 'Please select a number 1 through 5'
		switch -Exact ($mynum)
		{
			1 {DailyLogFiles("../Requirements1")}
			2 {ListFiles("../Requirements1")}
			3 {Get-Counter -SampleInterval 5 -MaxSamples 4}
			4 {Get-Process | Select-Object Name, ID, TotalProcessorTime | Sort-Object TotalProcessorTime -Descending | Out-GridView}
			5 {}
		}
	}
}
#Exception handling
Catch [System.OutOfMemoryException] 
{
	Write-Host -ForegroundColor $_.Exception.Message
}