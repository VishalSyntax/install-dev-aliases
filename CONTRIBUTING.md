# Contributing

Want to add Docker, kubectl, AWS CLI or something else? Here's how to do it.

---

## Getting started

Fork the repo, clone it, make a branch:

```cmd
gcl https://github.com/your-username/install-dev-aliases.git
gco -b feat/add-docker-aliases
```

---

## Adding a new alias group

Three files need to be updated:

### 1. `scripts/install.cmd`

Add a block in the `Creating CMD aliases` section:

```cmd
:: ---------- Docker ----------
(echo @echo off & echo docker %%*)           > "%ALIAS_DIR%\d.cmd"
(echo @echo off & echo docker ps %%*)        > "%ALIAS_DIR%\dps.cmd"
(echo @echo off & echo docker logs -f %%*)   > "%ALIAS_DIR%\dlogs.cmd"
```

### 2. `scripts/install.ps1`

Add to the `$cmdAliases` hashtable:

```powershell
"d.cmd"     = "docker %*"
"dps.cmd"   = "docker ps %*"
"dlogs.cmd" = "docker logs -f %*"
```

Add matching functions to the `$block` here-string:

```powershell
# Docker
function d       { docker @args }
function dps     { docker ps @args }
function dlogs   { docker logs -f @args }
```

### 3. Docs

- Add a table in `docs/aliases-reference.md`
- Update the summary in `docs/index.md`
- Update `README.md`

---

## Submitting a PR

```cmd
ga .
gc -m "feat: add Docker aliases"
gp origin feat/add-docker-aliases
```

Open a PR with a short note on what you added and why it's useful.

---

## Guidelines

- Keep alias names short (2–5 chars)
- Only add commands you'd actually use in real DevOps work
- Make sure it doesn't clash with an existing system command
- Test in both CMD and PowerShell before submitting
