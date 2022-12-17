@echo off
title Sharpening Config 2.1

set location="HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS"
set key="EnableGR535"
set value_OldSharpening="0"
set value_NewSharpening="1"

:PRESTART
reg query %location% /v %key%
if %ERRORLEVEL% EQU 0 goto START
if %ERRORLEVEL% EQU 1 goto ERROR

:START
reg query %location% /v %key% | Find "0x0"
cls
if %ERRORLEVEL% == 0 GOTO ENABLE_NEW_SHARPENING
if %ERRORLEVEL% == 1 GOTO ENABLE_OLD_SHARPENING

:ENABLE_NEW_SHARPENING
echo.
echo -----------------------------------------------------------
echo Old Nvidia Sharpening Options Detected (Better Performance)
echo -----------------------------------------------------------
echo.
set /P QUES=Enable New Sharpening Options (Y/N)?
if /I "%QUES%" NEQ "Y" GOTO ABORT
reg add %location% /v %key% /t REG_DWORD /d %value_NewSharpening% /f
reg query %location% /v %key% | Find "0x0"
cls
set result=New
if %ERRORLEVEL% == 0 GOTO NOT_SUCCESSFUL
if %ERRORLEVEL% == 1 GOTO SUCCESSFUL

:ENABLE_OLD_SHARPENING
echo.
echo ----------------------------------------------------------
echo New Nvidia Sharpening Options Detected (Lower Performance)
echo ----------------------------------------------------------
echo.
SET /P QUES=Enable Old Sharpening Options (Y/N)?
IF /I "%QUES%" NEQ "Y" GOTO ABORT
reg add %location% /v %key% /t REG_DWORD /d %value_OldSharpening% /f
reg query %location% /v %key% | Find "0x0"
cls
set result=Old
if %ERRORLEVEL% == 0 GOTO SUCCESSFUL
if %ERRORLEVEL% == 1 GOTO NOT_SUCCESSFUL

:SUCCESSFUL
cls
echo.
echo -----------------------------------------------
echo Success - %result% Nvidia Sharpening Options Enabled
echo -----------------------------------------------
GOTO END

:NOT_SUCCESSFUL
cls
echo.
echo ------------------------------------------------------
echo Not Successful - Nvidia Sharpening Options NOT Changed
echo           Make sure you have run as Admin!
echo ------------------------------------------------------
GOTO END

:ERROR
echo.
echo ------------------------------------------------
echo Error - Nvidia Sharpening Registry Key Not Found
echo ------------------------------------------------
GOTO END

:ABORT
cls
echo.
echo -----------------------------------
echo Aborted - No Changes Have Been Made
echo -----------------------------------
GOTO END

:END
echo.
echo Press any key to exit...
pause >nul
