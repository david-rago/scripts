@echo off
REM Check if the script is running with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this script as an administrator.
    pause
    exit /b 1
)

set "ruleName=Block ICMP Outbound"

REM Check the status of the firewall rule
netsh advfirewall firewall show rule name="%ruleName%" > nul 2>&1

if %errorlevel% equ 0 (
    REM Firewall Rule %ruleName% is enabled.
    echo Enabling ICMP
    netsh advfirewall firewall delete rule name="%ruleName%"
) else (
    REM Firewall Rule %ruleName% is not found or is disabled.
    echo Disabling ICMP
    netsh advfirewall firewall add rule name="%ruleName%" dir=out action=block protocol=icmpv4
)

pause