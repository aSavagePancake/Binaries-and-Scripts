@echo off
title Clear Event Viewer 3.1

:START
for /f "tokens=*" %%G in ('wevtutil.exe el') do (call :CLEAR_LOGS "%%G")
GOTO SUCCESS

:CLEAR_LOGS
echo clearing %1
wevtutil.exe cl %1
GOTO :EOF

:SUCCESS
echo.
echo ---------------------------------------
echo Success - ALL Event Viewer Logs Cleared
echo ---------------------------------------
GOTO END

:END
echo.
echo Press any key to exit...
pause >nul
