@echo off
setlocal

echo ==========================================
echo     Terraform + Git Alias Installer
echo       (CMD + PowerShell)
echo ==========================================
echo.

set "ALIAS_DIR=%USERPROFILE%\bin"

echo [1/4] Creating alias directory: %ALIAS_DIR%
if not exist "%ALIAS_DIR%" mkdir "%ALIAS_DIR%"

echo.
echo [2/4] Creating CMD aliases...

:: ---------- Terraform ----------
(echo @echo off & echo terraform %%*)           > "%ALIAS_DIR%\tf.cmd"
(echo @echo off & echo terraform init %%*)      > "%ALIAS_DIR%\tfi.cmd"
(echo @echo off & echo terraform plan %%*)      > "%ALIAS_DIR%\tfp.cmd"
(echo @echo off & echo terraform apply --auto-approve %%*)   > "%ALIAS_DIR%\tfa.cmd"
(echo @echo off & echo terraform destroy --auto-approve %%*) > "%ALIAS_DIR%\tfd.cmd"
(echo @echo off & echo terraform validate %%*)  > "%ALIAS_DIR%\tfv.cmd"
(echo @echo off & echo terraform fmt %%*)       > "%ALIAS_DIR%\tff.cmd"

:: ---------- Git ----------
(echo @echo off & echo git %%*)                 > "%ALIAS_DIR%\g.cmd"
(echo @echo off & echo git status %%*)          > "%ALIAS_DIR%\gs.cmd"
(echo @echo off & echo git add %%*)             > "%ALIAS_DIR%\ga.cmd"
(echo @echo off & echo git commit %%*)          > "%ALIAS_DIR%\gc.cmd"
(echo @echo off & echo git push %%*)            > "%ALIAS_DIR%\gp.cmd"
(echo @echo off & echo git pull %%*)            > "%ALIAS_DIR%\gl.cmd"
(echo @echo off & echo git branch %%*)          > "%ALIAS_DIR%\gb.cmd"
(echo @echo off & echo git checkout %%*)        > "%ALIAS_DIR%\gco.cmd"
(echo @echo off & echo git diff %%*)            > "%ALIAS_DIR%\gd.cmd"
(echo @echo off & echo git log --oneline %%*)   > "%ALIAS_DIR%\glog.cmd"

echo Done.

echo.
echo [3/4] Adding alias directory to User PATH...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$dir='%ALIAS_DIR%'; $path=[Environment]::GetEnvironmentVariable('Path','User'); if (($path -split ';') -notcontains $dir) { [Environment]::SetEnvironmentVariable('Path', ($path.TrimEnd(';') + ';' + $dir).Trim(';'), 'User'); Write-Host 'PATH updated.' } else { Write-Host 'PATH already contains the alias directory.' }"

echo.
echo [4/4] Adding PowerShell aliases to PS profile...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$profilePath = $PROFILE.CurrentUserAllHosts; if (!(Test-Path $profilePath)) { New-Item -ItemType File -Path $profilePath -Force | Out-Null }; $content = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue; $marker = '# --- dev-aliases ---'; if ($content -notlike \"*$marker*\") { $aliases = @\"`n$marker`", 'function tf      { terraform @args }', 'function tfi     { terraform init @args }', 'function tfp     { terraform plan @args }', 'function tfa     { terraform apply --auto-approve @args }', 'function tfd     { terraform destroy --auto-approve @args }', 'function tfv     { terraform validate @args }', 'function tff     { terraform fmt @args }', 'function g       { git @args }', 'function gs      { git status @args }', 'function ga      { git add @args }', 'function gc      { git commit @args }', 'function gp      { git push @args }', 'function gl      { git pull @args }', 'function gb      { git branch @args }', 'function gco     { git checkout @args }', 'function gd      { git diff @args }', 'function glog    { git log --oneline @args }', '# --- end dev-aliases ---'\"); Add-Content $profilePath ($aliases -join \"`n\"); Write-Host 'PowerShell aliases added to profile.' } else { Write-Host 'PowerShell aliases already present in profile.' }"

echo.
echo ==========================================
echo          Installation Complete!
echo ==========================================
echo.
echo Terraform aliases:
echo   tf   ^| tfi  ^| tfp  ^| tfa  ^| tfd  ^| tfv  ^| tff
echo.
echo Git aliases:
echo   g    ^| gs   ^| ga   ^| gc   ^| gp   ^| gl
echo   gb   ^| gco  ^| gd   ^| glog
echo.
echo Works in both CMD and PowerShell.
echo Restart your terminal to start using aliases.
echo.
pause
