#Requires -Version 5.0
<#
.SYNOPSIS
    Sets up a shared Terraform data directory for all projects.
.DESCRIPTION
    Creates C:\terraform-shared and sets TF_DATA_DIR permanently so all
    projects share one .terraform folder instead of downloading per project.
    Safe to run multiple times.
.EXAMPLE
    .\setup-terraform-cache.ps1
#>

$sharedDir = "C:\terraform-shared"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "    Terraform Shared Data Dir Setup"        -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# ── 1. Create shared directory ─────────────────────────────────────────────
Write-Host "[1/2] Creating shared Terraform directory..."
if (!(Test-Path $sharedDir)) {
    New-Item -ItemType Directory -Path $sharedDir -Force | Out-Null
    Write-Host "Created: $sharedDir"
} else {
    Write-Host "Already exists: $sharedDir"
}

# ── 2. Set TF_DATA_DIR environment variable ────────────────────────────────
Write-Host ""
Write-Host "[2/2] Setting TF_DATA_DIR environment variable..."
$current = [Environment]::GetEnvironmentVariable("TF_DATA_DIR", "User")
if ($current -ne $sharedDir) {
    [Environment]::SetEnvironmentVariable("TF_DATA_DIR", $sharedDir, "User")
    Write-Host "TF_DATA_DIR set to $sharedDir"
} else {
    Write-Host "TF_DATA_DIR already set."
}

# ── Summary ────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "Done! Run 'terraform init' again to use the shared directory." -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
