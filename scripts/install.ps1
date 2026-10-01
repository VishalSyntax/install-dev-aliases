#Requires -Version 5.0
<#
.SYNOPSIS
    Installs Terraform and Git aliases for CMD and PowerShell.
.DESCRIPTION
    Creates .cmd wrapper files in $HOME\bin for CMD usage and
    adds PowerShell functions to your PS profile.
.EXAMPLE
    .\install.ps1
#>

$aliasDir = "$HOME\bin"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "    Terraform + Git Alias Installer"        -ForegroundColor Cyan
Write-Host "      (CMD + PowerShell)"                   -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# ── 1. Create alias directory ──────────────────────────────────────────────
Write-Host "[1/4] Creating alias directory: $aliasDir"
if (!(Test-Path $aliasDir)) { New-Item -ItemType Directory -Path $aliasDir | Out-Null }

# ── 2. Create CMD .cmd files ───────────────────────────────────────────────
Write-Host ""
Write-Host "[2/4] Creating CMD aliases..."

$cmdAliases = @{
    "tf.cmd"   = "terraform %*"
    "tfi.cmd"  = "terraform init %*"
    "tfp.cmd"  = "terraform plan %*"
    "tfa.cmd"  = "terraform apply --auto-approve %*"
    "tfd.cmd"  = "terraform destroy --auto-approve %*"
    "tfv.cmd"  = "terraform validate %*"
    "tff.cmd"  = "terraform fmt %*"
    "tfo.cmd"  = "terraform output %*"
    "tfs.cmd"  = "terraform show %*"
    "tfws.cmd" = "terraform workspace %*"
    "g.cmd"    = "git %*"
    "gs.cmd"   = "git status %*"
    "ga.cmd"   = "git add %*"
    "gc.cmd"   = "git commit %*"
    "gp.cmd"   = "git push %*"
    "gl.cmd"   = "git pull %*"
    "gb.cmd"   = "git branch %*"
    "gco.cmd"  = "git checkout %*"
    "gd.cmd"   = "git diff %*"
    "glog.cmd" = "git log --oneline %*"
    "gst.cmd"  = "git stash %*"
    "gstp.cmd" = "git stash pop %*"
    "grs.cmd"  = "git restore %*"
    "grss.cmd" = "git restore --staged %*"
    "gm.cmd"   = "git merge %*"
    "grb.cmd"  = "git rebase %*"
    "grt.cmd"  = "git remote -v %*"
    "gcl.cmd"  = "git clone %*"
}

foreach ($file in $cmdAliases.Keys) {
    "@echo off`r`n$($cmdAliases[$file])" | Set-Content "$aliasDir\$file" -Encoding ASCII
}
Write-Host "Done."

# ── 3. Add alias dir to User PATH ──────────────────────────────────────────
Write-Host ""
Write-Host "[3/4] Adding alias directory to User PATH..."
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (($currentPath -split ";") -notcontains $aliasDir) {
    [Environment]::SetEnvironmentVariable("Path", ($currentPath.TrimEnd(";") + ";$aliasDir").Trim(";"), "User")
    Write-Host "PATH updated."
} else {
    Write-Host "PATH already contains the alias directory."
}

# ── 4. Add PowerShell functions to profile ─────────────────────────────────
Write-Host ""
Write-Host "[4/4] Adding PowerShell aliases to PS profile..."

$profilePath = $PROFILE.CurrentUserAllHosts
if (!(Test-Path $profilePath)) { New-Item -ItemType File -Path $profilePath -Force | Out-Null }

$startMarker = "# --- dev-aliases ---"
$endMarker   = "# --- end dev-aliases ---"

$block = @"

# --- dev-aliases ---
# Terraform
function tf      { terraform @args }
function tfi     { terraform init @args }
function tfp     { terraform plan @args }
function tfa     { terraform apply --auto-approve @args }
function tfd     { terraform destroy --auto-approve @args }
function tfv     { terraform validate @args }
function tff     { terraform fmt @args }
function tfo     { terraform output @args }
function tfs     { terraform show @args }
function tfws    { terraform workspace @args }

# Git
function g       { git @args }
function gs      { git status @args }
function ga      { git add @args }
function gc      { git commit @args }
function gp      { git push @args }
function gl      { git pull @args }
function gb      { git branch @args }
function gco     { git checkout @args }
function gd      { git diff @args }
function glog    { git log --oneline @args }
function gst     { git stash @args }
function gstp    { git stash pop @args }
function grs     { git restore @args }
function grss    { git restore --staged @args }
function gm      { git merge @args }
function grb     { git rebase @args }
function grt     { git remote -v @args }
function gcl     { git clone @args }
# --- end dev-aliases ---
"@

$existing = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue

# Remove old block if present, then append fresh block
if ($existing -match [regex]::Escape($startMarker)) {
    $cleaned = $existing -replace "(?s)`r?`n?$([regex]::Escape($startMarker)).*?$([regex]::Escape($endMarker))`r?`n?", ""
    Set-Content $profilePath $cleaned.TrimEnd() -Encoding UTF8
    Write-Host "Existing aliases removed — updating with latest version."
}

Add-Content $profilePath $block
Write-Host "PowerShell aliases written to profile: $profilePath"

# ── Summary ────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "         Installation Complete!"            -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Terraform aliases:" -ForegroundColor Yellow
Write-Host "  tf | tfi | tfp | tfa | tfd | tfv | tff | tfo | tfs | tfws"
Write-Host ""
Write-Host "Git aliases:" -ForegroundColor Yellow
Write-Host "  g | gs | ga | gc | gp | gl | gb | gco | gd | glog"
Write-Host "  gst | gstp | grs | grss | gm | grb | grt | gcl"
Write-Host ""
Write-Host "Works in both CMD and PowerShell." -ForegroundColor Cyan
Write-Host "Restart your terminal to start using aliases." -ForegroundColor Cyan
