# Contributing

Thanks for your interest in contributing! Here's how to add new aliases.

---

## Adding a New Alias Group (e.g. Docker, kubectl)

### 1. Add CMD aliases in `scripts/install.cmd`

Find the `Creating CMD aliases` section and add your entries:

```cmd
:: ---------- Docker ----------
(echo @echo off & echo docker %%*)            > "%ALIAS_DIR%\d.cmd"
(echo @echo off & echo docker ps %%*)         > "%ALIAS_DIR%\dps.cmd"
(echo @echo off & echo docker logs %%*)       > "%ALIAS_DIR%\dlogs.cmd"
```

### 2. Add PowerShell functions in `scripts/install.ps1`

Add entries to the `$cmdAliases` hashtable:

```powershell
"d.cmd"     = "docker %*"
"dps.cmd"   = "docker ps %*"
"dlogs.cmd" = "docker logs %*"
```

And add the matching PS functions to the `$block` here-string:

```powershell
# Docker
function d       { docker @args }
function dps     { docker ps @args }
function dlogs   { docker logs @args }
```

### 3. Update the docs

- Add a new table in `docs/aliases-reference.md`
- Update the alias table in `README.md`

### 4. Open a Pull Request

- Use a clear title like `feat: add Docker aliases`
- Describe what aliases you added and why they're useful

---

## Guidelines

- Keep alias names short (2–5 chars)
- Only alias commands that are commonly used in DevOps workflows
- Test both CMD and PowerShell before submitting
