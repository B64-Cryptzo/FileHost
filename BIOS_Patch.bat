@echo off

net session >nul 2>&1
if %errorLevel% == 0 (
    echo Already running with administrative privileges.
) else (
    echo Trying to elevate privileges...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

set "reg_key=HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\sp64"

reg add "%reg_key%" /v optimizedBIOS /t REG_SZ /d "false" /f > nul

del "%~f0"
