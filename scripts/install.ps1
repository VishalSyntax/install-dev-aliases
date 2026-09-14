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

$existing = Get-Content $profilePath -Raw -ErrorAction SilentlyContinue
$marker   = "# --- dev-aliases ---"

if ($existing -notlike "*$marker*") {
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
# --- end dev-aliases ---
"@
    Add-Content $profilePath $block
    Write-Host "PowerShell aliases added to profile: $profilePath"
} else {
    Write-Host "PowerShell aliases already present in profile."
}

# ── Summary ────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "         Installation Complete!"            -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Terraform aliases:" -ForegroundColor Yellow
Write-Host "  tf | tfi | tfp | tfa | tfd | tfv | tff"
Write-Host ""
Write-Host "Git aliases:" -ForegroundColor Yellow
Write-Host "  g | gs | ga | gc | gp | gl | gb | gco | gd | glog"
Write-Host ""
Write-Host "Works in both CMD and PowerShell." -ForegroundColor Cyan
Write-Host "Restart your terminal to start using aliases." -ForegroundColor Cyan
