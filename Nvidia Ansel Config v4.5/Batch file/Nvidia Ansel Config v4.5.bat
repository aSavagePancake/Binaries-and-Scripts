@echo off
title Ansel Config 4.5

:PRESTART
C:
cd C:\Windows\System32\DriverStore\FileRepository\nv_dispig.inf*
cd NvCamera
if exist NvCameraEnable.exe (echo DCH Driver Detected
echo Desktop Driver Detected
GOTO START)
cls
cd C:\Windows\System32\DriverStore\FileRepository\nv_dispi.inf*
cd NvCamera
if exist NvCameraEnable.exe (echo DCH Driver Detected
echo Desktop Driver Detected
GOTO START)
cls
cd C:\Windows\System32\DriverStore\FileRepository\nvam.inf*
cd NvCamera
if exist NvCameraEnable.exe (echo DCH Driver Detected
echo Laptop Driver Detected
GOTO START)
cls
cd C:\Windows\System32\DriverStore\FileRepository\nvacegpu.inf*
cd NvCamera
if exist NvCameraEnable.exe (echo DCH Driver Detected
echo Laptop Driver Detected
GOTO START)
cls
cd C:\Windows\System32\DriverStore\FileRepository\nvacig.inf*
cd NvCamera
if exist NvCameraEnable.exe (echo DCH Driver Detected
echo Laptop Driver Detected
GOTO START)
cls
cd C:\Windows\System32\DriverStore\FileRepository\nvmdi.inf*
cd NvCamera
if exist NvCameraEnable.exe (echo DCH Driver Detected
echo Desktop Driver Detected
GOTO START)
cls
cd C:\Windows\System32\DriverStore\FileRepository\nvami.inf*
cd NvCamera
if exist NvCameraEnable.exe (echo DCH Driver Detected
echo Laptop Driver Detected
GOTO START)
cls
cd "C:\Program Files\NVIDIA Corporation\Ansel\Tools"
if exist NvCameraEnable.exe (echo Standard Driver Detected
GOTO START)
cls
cd "C:\Program Files\NVIDIA Corporation\Ansel"
if exist NvCameraEnable.exe (echo Standard Driver Detected
GOTO START)
cls
GOTO ERROR

:START
for /f %%i in ('NvCameraEnable') do set ANSEL=%%i
if %ANSEL% EQU 0 (GOTO ENABLE) else (GOTO DISABLE)

:DISABLE
echo %1--------------------------&echo Ansel is Currently ENABLED&echo --------------------------
echo.
SET /P QUES=Do you want to Disable Ansel (Y/N)?
IF /I "%QUES%" NEQ "Y" GOTO ABORT
NvCameraEnable.exe off
timeout 1 /nobreak >nul
for /f %%i in ('NvCameraEnable') do set ANSEL=%%i
if %ANSEL% NEQ 0 (GOTO ERROR)
cls
set result=DISABLED
GOTO SUCCESS

:ENABLE
echo %1---------------------------&echo Ansel is Currently Disabled&echo ---------------------------
echo.
SET /P QUES=Do you want to Enable Ansel (Y/N)?
IF /I "%QUES%" NEQ "Y" GOTO ABORT
NvCameraEnable.exe on
timeout 1 /nobreak >nul
for /f %%i in ('NvCameraEnable') do set ANSEL=%%i
if %ANSEL% NEQ 1 (GOTO ERROR)
cls
set result=ENABLED
GOTO SUCCESS

:SUCCESS
echo.
echo -------------------------------
echo Success - %result% Nvidia Ansel
echo -------------------------------
GOTO END

:ERROR
echo.
echo -------------------------------------
echo Error - Unable to locate Nvidia Ansel
echo -------------------------------------
GOTO END

:ABORT
echo.
echo -----------------------------------
echo Aborted - No Changes Have Been Made
echo -----------------------------------
GOTO END

:END
echo.
echo Press any key to exit...
pause >nul
