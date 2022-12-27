$host.UI.RawUI.WindowTitle = "Choco App Installer v1.0"
$packages = Get-Content -Path .\ChocoAppList.txt

$MainMenu = {
cls
Write-Host
Write-Host " *****************************************"
Write-Host " *        Choco App Installer v1.0        "
Write-Host " *****************************************"
Write-Host
Write-Host " 1.) Download & Install Chocolatey"
Write-Host " -----------------------------------------"
Write-Host " 2.) Upgrade Chocolatey"
Write-Host " -----------------------------------------"
Write-Host " 3.) Install ALL Apps (ChocoAppList)"
Write-Host " 4.) Uninstall ALL Apps (ChocoAppList)"
Write-Host " -----------------------------------------"
Write-Host " 5.) Upgrade ALL Apps (ChocoAppList)"
Write-Host " -----------------------------------------"
Write-Host " 6.) Edit ChocoAppList.txt"
Write-Host " 7.) Quit"
Write-Host
Write-Host " Select an option and press Enter: "  -nonewline
}

function InstallChoco {
   cls
   Write-Host
   Write-Host " *****************************************"
   Write-Host " *         Installing Chocolatey         *"
   Write-Host " *****************************************"
   Write-Host
   Write-Host
   if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
      "Chocolatey already installed"
   } else {
      Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   }   
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null        
}

function UpgradeChoco {
   cls
   Write-Host
   Write-Host " *****************************************"
   Write-Host " *          Upgrading Chocolatey         *"
   Write-Host " *****************************************"
   Write-Host
   Write-Host
   if (Get-Command choco.exe -ErrorAction SilentlyContinue) { 
      choco upgrade chocolatey
   } else {
      "Chocolatey not currently installed"  
   }
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function InstallAllApps {
   cls
   Write-Host
   Write-Host " *****************************************"
   Write-Host " *          Installing ALL Apps          *"
   Write-Host " *****************************************"
   Write-Host
   Write-Host
   if (Get-Command choco.exe -ErrorAction SilentlyContinue) {      
      foreach($packageName in $packages)
   {
      choco install $packageName -y
   }
   } else {
      "Chocolatey not currently installed"  
   }      
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function UninstallAllApps {
   cls
   Write-Host
   Write-Host " *****************************************"
   Write-Host " *         Uninstalling ALL Apps         *"
   Write-Host " *****************************************"
   Write-Host
   Write-Host
   if (Get-Command choco.exe -ErrorAction SilentlyContinue) {      
      foreach($packageName in $packages)
   {
      choco uninstall $packageName -y
   }   
   } else {
      "Chocolatey not currently installed"  
   }
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function UpdateAllApps {
   cls
   Write-Host
   Write-Host " *****************************************"
   Write-Host " *           Updating ALL Apps           *"
   Write-Host " *****************************************"
   Write-Host
   Write-Host
   if (Get-Command choco.exe -ErrorAction SilentlyContinue) {
      foreach($packageName in $packages)
   {
      choco upgrade $packageName -y
   }   
   } else {
      "Chocolatey not currently installed"  
   }
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function EditAppList {
   cls
   Write-Host
   Write-Host " *****************************************"
   Write-Host " *       Editing: ChocoAppList.txt       *"
   Write-Host " *****************************************"
   Write-Host
   Write-Host
   Invoke-Item ./ChocoAppList.txt
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

Do {
Invoke-Command $MainMenu
$Select = Read-Host
Switch ($Select)
   {
      1 { 
         InstallChoco 
      }      
      2 { 
         UpgradeChoco 
      }
      3 { 
         InstallAllApps 
      }
      4 { 
         UninstallAllApps 
      }
      5 {
         UpdateAllApps
      }
      6 { 
         EditAppList 
      }         
   }
}
While ($Select -ne 7)
