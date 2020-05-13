<# Crea el cmdlet para mostrar el menu #>
function Show-Menu
{
 param(
     [string]$Title = 'My Menu'
 )
 Clear-Host
 Write-Host "================== $Title =================="
 Write-Host "1: Press '1' for display the five processes that are consuming the most CPU at the moment."
 Write-Host "2: Press '2' for display the filesystems or disks connected to the machine. Include for each disk its size and the amount of free space (in bytes)."
 Write-Host "3: Press '3' for display the name and size of the largest file stored on a disk or filesystem that the user must specify. The file should appear with its full path."
 Write-Host "4: Press '4' for display the amount of free memory and amount of swap space in use (in bytes and percentage). "
 Write-Host "5: Press '5' for display the number of currently active network connections (in ESTABLISHED state)."
 Write-Host "Q: Press 'Q' to quit"

}
<# Se encarga de mostrar el punto 3 del proyecto #>
function Show-LargestFile
{
 param(
    
 )
 
 $ruta = Read-Host "Please put the directory path where you want to search: " 
 Write-Host "Loading...."
 Get-ChildItem -Path $ruta -Recurse| Sort-Object -Property Length -Descending | select  Name, Length, FullName -first 1|ft Mode, Name,@{n='Length (MB)';e={$_.Length / 1MB -as [int]}}, @{n='Path';e={$_.FullName}} -AutoSize
 

}
<# Se encarga de mostrar el punto 2 del proyecto #>
function Show-Two
{
 param(
    
 )
 
 Write-Host "Loading...."
 Get-WmiObject -Class Win32_LogicalDisk | Select-Object name,@{n='Size (Bytes)'; e={$_.size}},@{n='Free Space (Bytes)'; e={$_.freespace}}
}
<# Se encarga de mostrar el punto 4 del proyecto #>
function Show-Four{
    Write-Host "Loading...."
    $freememory = ((Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty FreePhysicalMemory)*1024)
    $fpusage = (Get-CimInstance -ClassName Win32_PageFileUsage).CurrentUsage*1024*1024
    $totalmemory = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum
    $totalfp= (Get-CimInstance -ClassName Win32_PageFileUsage).AllocatedBaseSize*1024*1024
    "Free Virtual Memory = ${freememory} bytes | " + [math]::round((($freememory/$totalmemory)*100),2) + " %"
    "FilePage usage = ${fpusage} bytes | " + [math]::round((($fpusage/$totalfp)*100),2) + " %"
}
<# Se encarga de mostrar los puntos en segun la opción que escoja el usuario del proyecto #>
do {
    Show-Menu -Title "Process Manager"
    $UserInput = Read-Host "Please make a selection"
    switch ($UserInput) {
        '1' {Get-Process | Sort CPU -descending | Select -first 5 -Property ID,ProcessName,CPU | format-table -autosize}
        '2' {Show-Two}
        '3' {Show-LargestFile}
        '4' {Show-Four}
        '5' {(Get-NetTCPConnection | ? {$_.State -eq "ESTABLISHED"}).count}
        
    }
   pause

} until ( $UserInput -eq 'q')
