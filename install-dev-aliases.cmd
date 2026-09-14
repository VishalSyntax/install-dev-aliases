@echo off
setlocal

echo ==========================================
echo     Terraform + Git Alias Installer
echo ==========================================
echo.

set "ALIAS_DIR=%USERPROFILE%\bin"

echo Creating alias directory:
echo %ALIAS_DIR%
if not exist "%ALIAS_DIR%" mkdir "%ALIAS_DIR%"

echo.
echo Creating Terraform aliases...

(
echo @echo off
echo terraform %%*
) > "%ALIAS_DIR%\tf.cmd"

(
echo @echo off
echo terraform init %%*
) > "%ALIAS_DIR%\tfi.cmd"

(
echo @echo off
echo terraform plan %%*
) > "%ALIAS_DIR%\tfp.cmd"

(
echo @echo off
echo terraform apply --auto-approve %%*
) > "%ALIAS_DIR%\tfa.cmd"

(
echo @echo off
echo terraform destroy --auto-approve %%*
) > "%ALIAS_DIR%\tfd.cmd"

(
echo @echo off
echo terraform validate %%*
) > "%ALIAS_DIR%\tfv.cmd"

(
echo @echo off
echo terraform fmt %%*
) > "%ALIAS_DIR%\tff.cmd"


echo.
echo Creating Git aliases...

(
echo @echo off
echo git %%*
) > "%ALIAS_DIR%\g.cmd"

(
echo @echo off
echo git status %%*
) > "%ALIAS_DIR%\gs.cmd"

(
echo @echo off
echo git add %%*
) > "%ALIAS_DIR%\ga.cmd"

(
echo @echo off
echo git commit %%*
) > "%ALIAS_DIR%\gc.cmd"

(
echo @echo off
echo git push %%*
) > "%ALIAS_DIR%\gp.cmd"

(
echo @echo off
echo git pull %%*
) > "%ALIAS_DIR%\gl.cmd"

(
echo @echo off
echo git branch %%*
) > "%ALIAS_DIR%\gb.cmd"

(
echo @echo off
echo git checkout %%*
) > "%ALIAS_DIR%\gco.cmd"

(
echo @echo off
echo git diff %%*
) > "%ALIAS_DIR%\gd.cmd"

(
echo @echo off
echo git log --oneline %%*
) > "%ALIAS_DIR%\glog.cmd"


echo.
echo Adding alias directory to User PATH...

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
 "$dir='%ALIAS_DIR%'; $path=[Environment]::GetEnvironmentVariable('Path','User'); if (($path -split ';') -notcontains $dir) { [Environment]::SetEnvironmentVariable('Path', (($path.TrimEnd(';') + ';' + $dir).Trim(';')), 'User'); Write-Host 'PATH updated.' } else { Write-Host 'PATH already contains the alias directory.' }"

echo.
echo ==========================================
echo          Installation Complete
echo ==========================================
echo.

echo Terraform:
echo   tf   = terraform
echo   tfi  = terraform init
echo   tfp  = terraform plan
echo   tfa  = terraform apply --auto-approve
echo   tfd  = terraform destroy --auto-approve
echo   tfv  = terraform validate
echo   tff  = terraform fmt
echo.

echo Git:
echo   g    = git
echo   gs   = git status
echo   ga   = git add
echo   gc   = git commit
echo   gp   = git push
echo   gl   = git pull
echo   gb   = git branch
echo   gco  = git checkout
echo   gd   = git diff
echo   glog = git log --oneline
echo.

echo Close and reopen CMD / PowerShell before using the aliases.
echo.
pause