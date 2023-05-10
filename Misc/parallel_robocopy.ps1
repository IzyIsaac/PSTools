###
#
# This script was found at
# https://support.zadarastorage.com/hc/en-us/articles/213024806-How-to-Run-Robocopy-in-Parallel
# I have adjusted robocopy parameters to be optimized for migrating a file share
# and keeping all NTFS permissions. I have also adjusted some of the script for readability
#
# This script runs robocopy jobs in parallel by increasing the number of outstanding i/o's to the copy process. Even though you can
# change the number of threads using the "/mt:#" parameter, your backups will run faster by adding two or more jobs to your
# original set. 
#
# To do this, you need to subdivide the work into directories. That is, each job will recurse the directory until completed.
# The ideal case is to have 100's of directories as the root of the backup. Simply change $src to get
# the list of folders to backup and the list is used to feed $ScriptBlock.
# 
# For maximum SMB throughput, do not exceed 8 concurrent Robocopy jobs with 20 threads. Any more will degrade
# the performance by causing disk thrashing looking up directory entries. Lower the number of threads to 8 if one
# or more of your volumes are encrypted.
#
# Parameters:
# $src Change this to a directory which has lots of subdirectories that can be processed in parallel 
# $dest Change this to where you want to backup your files to
# $max_jobs Change this to the number of parallel jobs to run ( <= 8 )
# $log Change this to the directory where you want to store the output of each robocopy job.
#
####
#
# This script will throttle the number of concurrent jobs based on $max_jobs
#
$max_jobs = 2
$tstart = get-date
#
# Set $src to a directory with lots of sub-directories
#
$src = "\\Directory\or\UNC"
#
# Set $dest to a local folder or share you want to back up the data to
#
$dest = "X:\"
#
# Set $log to a local folder to store logfiles
#
$log = "c:\robo\Logs\"
mkdir $log
$files = Get-ChildItem $src
$files | ForEach-Object{
    $ScriptBlock = {
        param($name, $src, $dest, $log)
        $log += "\$name-$(get-date -f yyyy-MM-dd-mm-ss).log"
        robocopy $src$name $dest$name /MT:16 /R:1 /W:1 /B /MIR /IT /COPY:DATSO /DCOPY:DAT /NP /NFL /NDL /XD "System Volume Information" > $log
        Write-Host $src$name " completed"
    }
    $j = Get-Job -State "Running"
    while ($j.count -ge $max_jobs) 
    {
        Start-Sleep -Milliseconds 500
        $j = Get-Job -State "Running"
    }
    Get-job -State "Completed" | Receive-job
    Remove-job -State "Completed"
    Start-Job $ScriptBlock -ArgumentList $_,$src,$dest,$log
}
#
# No more jobs to process. Wait for all of them to complete
#

While (Get-Job -State "Running") { Start-Sleep 2 }
Remove-Job -State "Completed" 
Get-Job | Write-host

$tend = get-date

new-timespan -start $tstart -end $tend