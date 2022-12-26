﻿##[Ps1 To Exe]
##
##NcDBCIWOCzWE8pGP3wFk4Fn9flsqeMScvIamyoK99O/QnyDKQo4bWWhZkz68AkSxXfcAadcUoNIZFRsjI/c3xKDVCO+IVbImm/BrJfGWstI=
##NcDBCIWOCzWE8pGP3wFk4Fn9flsqeMScvIamyoK99O/QnyDKQo4bWWhZkz68AkSxXfcAadcUoNIZFRsjI/c30bHfFPfnVbFb8g==
##Kd3HDZOFADWE8uO1
##Nc3NCtDXTlaDjofG5iZk2XjvVGksa/Wat7Wmz4SA2+X7tSnWSJ4HdXl2hD3mXRvwevsAVvkQ+eEdUAVkJvEEgg==
$host.UI.RawUI.WindowTitle = "Fresh App Installer v2.1"

$ScoopLocation = 'C:\Software\Scoop'
$ScoopAppsLocation = 'C:\Software'
$array = Get-Content -Path .\FreshAppList.txt

$MainMenu = {
cls
Write-Host
Write-Host " *******************************"
Write-Host " *   Fresh App Installer v2.1   "
Write-Host " *******************************"
Write-Host
Write-Host " 1.) Install Scoop"
Write-Host " 2.) Uninstall Scoop"
Write-Host " -------------------------------"
Write-Host " 3.) Update Scoop"
Write-Host " -------------------------------"
Write-Host " 4.) Install ALL Apps"
Write-Host " 5.) Uninstall ALL Apps"
Write-Host " -------------------------------"
Write-Host " 6.) Update ALL Apps"
Write-Host " -------------------------------"
Write-Host " 7.) Edit FreshAppList.txt"
Write-Host " 8.) Quit"
Write-Host
Write-Host " Select an option and press Enter: "  -nonewline
}

function InstallScoop {
   cls
   Write-Host
   Write-Host " *******************************"
   Write-Host " *       Installing Scoop      *"
   Write-Host " *******************************"
   Write-Host
   Write-Host
   if (Test-Path -Path $ScoopLocation) {
      "Scoop already installed"
   } else {
      . .\Scoop.ps1 -ScoopDir $ScoopLocation -ScoopGlobalDir $ScoopAppsLocation -NoProxy
      scoop install aria2
      scoop config aria2-warning-enabled false   
   }   
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null        
}

function UninstallScoop {
   cls
   Write-Host
   Write-Host " *******************************"
   Write-Host " *      Uninstalling Scoop     *"
   Write-Host " *******************************"
   Write-Host
   Write-Host
   if (Test-Path -Path $ScoopLocation) {
      scoop uninstall git
      scoop uninstall 7zip
      scoop uninstall aria2
      scoop uninstall innounp
      scoop uninstall scoop
      rm $ScoopLocation -r -force
   } else {
      "Scoop not currently installed"
   }   
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function UpdateScoop {
   cls
   Write-Host
   Write-Host " *******************************"
   Write-Host " *        Updating Scoop       *"
   Write-Host " *******************************"
   Write-Host
   Write-Host
   if (Test-Path -Path $ScoopLocation) {
      scoop install git
      scoop update
   } else {
      "Scoop not currently installed"  
   }
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function InstallAllApps {
   cls
   Write-Host
   Write-Host " *******************************"
   Write-Host " *     Installing ALL Apps     *"
   Write-Host " *******************************"
   Write-Host
   Write-Host
   if (Test-Path -Path $ScoopLocation) {
      scoop bucket add extras
      scoop bucket add versions
      foreach($item in $array)
   {
      scoop install $item 
   }
   } else {
      "Scoop not currently installed"  
   }      
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function UninstallAllApps {
   cls
   Write-Host
   Write-Host " *******************************"
   Write-Host " *    Uninstalling ALL Apps    *"
   Write-Host " *******************************"
   Write-Host
   Write-Host
   if (Test-Path -Path $ScoopLocation) {
      scoop bucket add extras
      scoop bucket add versions
      foreach($item in $array)
   {
      scoop uninstall $item
   }   
   } else {
      "Scoop not currently installed"  
   }
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function UpdateAllApps {
   cls
   Write-Host
   Write-Host " *******************************"
   Write-Host " *      Updating ALL Apps      *"
   Write-Host " *******************************"
   Write-Host
   Write-Host
   if (Test-Path -Path $ScoopLocation) {
      scoop bucket add extras
      scoop bucket add versions
      foreach($item in $array)
   {
      scoop update $item
   }   
   } else {
      "Scoop not currently installed"  
   }
   Write-Host
   Write-Host "Press any key continue"
   $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
}

function EditAppList {
   cls
   Write-Host
   Write-Host " *******************************"
   Write-Host " *  Editing: FreshAppList.txt  *"
   Write-Host " *******************************"
   Write-Host
   Write-Host
   Invoke-Item ./FreshAppList.txt
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
         InstallScoop 
      }
      2 { 
         UninstallScoop 
      }
      3 { 
         UpdateScoop 
      }
      4 { 
         InstallAllApps 
      }
      5 { 
         UninstallAllApps 
      }
      6 {
         UpdateAllApps
      }
      7 { 
         EditAppList 
      }         
   }
}
While ($Select -ne 8)
