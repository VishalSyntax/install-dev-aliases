# Contributing

If you want to add aliases for Docker, kubectl, AWS CLI or anything else — go for it. Here's how.

---

## Getting started

Fork the repo, clone it, create a branch:

```cmd
gcl https://github.com/your-username/install-dev-aliases.git
gco -b feat/add-docker-aliases
```

---

## Adding a new tool

You need to touch three places:

### 1. `scripts/install.cmd`

Add a block under the `Creating CMD aliases` section:

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

And add the matching functions to the `$block` here-string:

```powershell
# Docker
function d       { docker @args }
function dps     { docker ps @args }
function dlogs   { docker logs -f @args }
```

### 3. Docs

- Add a table in `docs/aliases-reference.md`
- Update the summary table in `docs/index.md`
- Update `README.md`

---

## Submitting

```cmd
ga .
gc -m "feat: add Docker aliases"
gp origin feat/add-docker-aliases
```

Open a PR with a short description of what you added and why it's useful.

---

## A few things to keep in mind

- Keep alias names short — 2 to 5 characters
- Only add commands you'd actually use in real DevOps work
- Make sure it doesn't clash with an existing system command
- Test it in both CMD and PowerShell before submitting
