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
(echo @echo off & echo terraform output %%*)    > "%ALIAS_DIR%\tfo.cmd"
(echo @echo off & echo terraform show %%*)      > "%ALIAS_DIR%\tfs.cmd"
(echo @echo off & echo terraform workspace %%*) > "%ALIAS_DIR%\tfws.cmd"

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
(echo @echo off & echo git stash %%*)           > "%ALIAS_DIR%\gst.cmd"
(echo @echo off & echo git stash pop %%*)       > "%ALIAS_DIR%\gstp.cmd"
(echo @echo off & echo git restore %%*)         > "%ALIAS_DIR%\grs.cmd"
(echo @echo off & echo git restore --staged %%*) > "%ALIAS_DIR%\grss.cmd"
(echo @echo off & echo git merge %%*)           > "%ALIAS_DIR%\gm.cmd"
(echo @echo off & echo git rebase %%*)          > "%ALIAS_DIR%\grb.cmd"
(echo @echo off & echo git remote -v %%*)       > "%ALIAS_DIR%\grt.cmd"
(echo @echo off & echo git clone %%*)           > "%ALIAS_DIR%\gcl.cmd"

echo Done.

echo.
echo [3/4] Adding alias directory to User PATH...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$dir='%ALIAS_DIR%'; $path=[Environment]::GetEnvironmentVariable('Path','User'); if (($path -split ';') -notcontains $dir) { [Environment]::SetEnvironmentVariable('Path', ($path.TrimEnd(';') + ';' + $dir).Trim(';'), 'User'); Write-Host 'PATH updated.' } else { Write-Host 'PATH already contains the alias directory.' }"

echo.
echo [4/4] Adding PowerShell aliases to PS profile...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$profilePath = $PROFILE.CurrentUserAllHosts; if (!(Test-Path $profilePath)) { New-Item -ItemType File -Path $profilePath -Force | Out-Null }; $startMarker = '# --- dev-aliases ---'; $endMarker = '# --- end dev-aliases ---'; $existing = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue; if ($existing -match [regex]::Escape($startMarker)) { $cleaned = $existing -replace ('(?s)`r?`n?' + [regex]::Escape($startMarker) + '.*?' + [regex]::Escape($endMarker) + '`r?`n?'), ''; Set-Content $profilePath $cleaned.TrimEnd() -Encoding UTF8; Write-Host 'Existing aliases removed - updating with latest version.' }; $block = \"`n# --- dev-aliases ---`nfunction tf      { terraform @args }`nfunction tfi     { terraform init @args }`nfunction tfp     { terraform plan @args }`nfunction tfa     { terraform apply --auto-approve @args }`nfunction tfd     { terraform destroy --auto-approve @args }`nfunction tfv     { terraform validate @args }`nfunction tff     { terraform fmt @args }`nfunction tfo     { terraform output @args }`nfunction tfs     { terraform show @args }`nfunction tfws    { terraform workspace @args }`nfunction g       { git @args }`nfunction gs      { git status @args }`nfunction ga      { git add @args }`nfunction gc      { git commit @args }`nfunction gp      { git push @args }`nfunction gl      { git pull @args }`nfunction gb      { git branch @args }`nfunction gco     { git checkout @args }`nfunction gd      { git diff @args }`nfunction glog    { git log --oneline @args }`nfunction gst     { git stash @args }`nfunction gstp    { git stash pop @args }`nfunction grs     { git restore @args }`nfunction grss    { git restore --staged @args }`nfunction gm      { git merge @args }`nfunction grb     { git rebase @args }`nfunction grt     { git remote -v @args }`nfunction gcl     { git clone @args }`n# --- end dev-aliases ---\"; Add-Content $profilePath $block; Write-Host 'PowerShell aliases written to profile.'"

echo.
echo ==========================================
echo          Installation Complete!
echo ==========================================
echo.
echo Terraform aliases:
echo   tf   ^| tfi  ^| tfp  ^| tfa  ^| tfd  ^| tfv  ^| tff  ^| tfo  ^| tfs  ^| tfws
echo.
echo Git aliases:
echo   g    ^| gs   ^| ga   ^| gc   ^| gp   ^| gl   ^| gb   ^| gco
echo   gd   ^| glog ^| gst  ^| gstp ^| grs  ^| grss ^| gm   ^| grb  ^| grt  ^| gcl
echo.
echo Works in both CMD and PowerShell.
echo Restart your terminal to start using aliases.
echo.
pause
