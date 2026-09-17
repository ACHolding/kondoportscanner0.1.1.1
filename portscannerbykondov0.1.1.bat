@echo off
title Kondo's Batch Script 0.1 - Port Scanner
color 0B

echo ==========================================
echo        KONDO'S BATCH SCRIPT 0.1
echo              PORT SCANNER
echo ==========================================
echo.
echo Use only on systems you own or have
echo permission to test.
echo.

set /p TARGET="Target IP/hostname: "
set /p STARTPORT="Starting port: "
set /p ENDPORT="Ending port: "

echo.
echo Scanning %TARGET% ports %STARTPORT%-%ENDPORT%...
echo.

for /L %%P in (%STARTPORT%,1,%ENDPORT%) do (
    powershell -NoProfile -Command ^
      "$c = New-Object Net.Sockets.TcpClient; try {$r=$c.BeginConnect('%TARGET%',%%P,$null,$null); if($r.AsyncWaitHandle.WaitOne(250) -and $c.Connected){Write-Host '[OPEN] %%P'} } catch {} finally {$c.Close()}"
)

echo.
echo ==========================================
echo Scan complete.
echo ==========================================
pause
