@echo off
setlocal

echo ==========================================
echo     Terraform Shared Data Dir Setup
echo ==========================================
echo.

set "SHARED_DIR=C:\terraform-shared"

echo [1/2] Creating shared Terraform directory...
if not exist "%SHARED_DIR%" (
    mkdir "%SHARED_DIR%"
    echo Created: %SHARED_DIR%
) else (
    echo Already exists: %SHARED_DIR%
)

echo.
echo [2/2] Setting TF_DATA_DIR environment variable...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$val = 'C:\terraform-shared'; $cur = [Environment]::GetEnvironmentVariable('TF_DATA_DIR','User'); if ($cur -ne $val) { [Environment]::SetEnvironmentVariable('TF_DATA_DIR', $val, 'User'); Write-Host 'TF_DATA_DIR set.' } else { Write-Host 'TF_DATA_DIR already set.' }"

echo.
echo ==========================================
echo Done! Run 'terraform init' again to use the shared directory.
echo ==========================================
echo.
pause
