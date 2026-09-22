# Installation

Just pick whichever script matches your shell and run it. Both do the exact same thing.

---

## What it sets up

- `.cmd` wrapper files in `%USERPROFILE%\bin` so aliases work in CMD
- PowerShell functions added to your `$PROFILE` so aliases work in PS too
- `%USERPROFILE%\bin` added to your User `PATH` automatically
- Re-running the script is safe — it always updates to the latest aliases

---

## CMD

Double-click the file or run it from any terminal:

[Download install.cmd](https://raw.githubusercontent.com/VishalSyntax/install-dev-aliases/main/scripts/install.cmd){ .md-button .md-button--primary }

```cmd
scripts\install.cmd
```

---

## PowerShell

If you haven't done this before, you need to allow local scripts first:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Then run the installer:

[Download install.ps1](https://raw.githubusercontent.com/VishalSyntax/install-dev-aliases/main/scripts/install.ps1){ .md-button .md-button--primary }

```powershell
.\scripts\install.ps1
```

---

> **Restart your terminal after running the script** — otherwise the aliases won't be available yet.

---

## Quick check

After restarting, try these to confirm everything works:

```bash
tf --version    # runs: terraform --version
gs              # runs: git status
glog            # runs: git log --oneline
```

---

## Manual Setup (no script)

If you'd rather do it yourself, here's exactly what the script does step by step.

### 1. Create the alias directory

```cmd
mkdir %USERPROFILE%\bin
```

### 2. Create CMD alias files

For each alias, create a `.cmd` file in `%USERPROFILE%\bin`. For example:

```cmd
echo @echo off > %USERPROFILE%\bin\tf.cmd
echo terraform %%* >> %USERPROFILE%\bin\tf.cmd

echo @echo off > %USERPROFILE%\bin\tfi.cmd
echo terraform init %%* >> %USERPROFILE%\bin\tfi.cmd
```

Repeat for each alias you want. See the full list in [Alias Reference](aliases-reference.md).

### 3. Add to PATH

Open **Start → Edit environment variables for your account** → find `Path` → click Edit → add `%USERPROFILE%\bin`.

Or run this in PowerShell:

```powershell
$path = [Environment]::GetEnvironmentVariable('Path','User')
[Environment]::SetEnvironmentVariable('Path', $path + ';' + "$HOME\bin", 'User')
```

### 4. Add PowerShell aliases

Open your PowerShell profile:

```powershell
notepad $PROFILE
```

If the file doesn't exist yet:

```powershell
New-Item -ItemType File -Path $PROFILE -Force
```

Add these functions at the bottom:

```powershell
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
```

Save and restart your terminal.
