# 🛠️ dev-aliases

> One-click installer for Terraform and Git aliases on Windows — works in both **CMD** and **PowerShell**.

Tired of typing `terraform apply --auto-approve` every time? This repo installs short, memorable aliases so you can move faster in the terminal.

---

## 📦 What's Included

| Tool      | Aliases installed |
|-----------|-------------------|
| Terraform | `tf` `tfi` `tfp` `tfa` `tfd` `tfv` `tff` |
| Git       | `g` `gs` `ga` `gc` `gp` `gl` `gb` `gco` `gd` `glog` |

> Docker and kubectl aliases coming soon — contributions welcome!

---

## 🚀 Installation

### Option 1 — CMD (double-click or run in terminal)

```cmd
scripts\install.cmd
```

### Option 2 — PowerShell

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned   # one-time
.\scripts\install.ps1
```

Both scripts do the same thing:
- Create `.cmd` wrapper files in `%USERPROFILE%\bin` (for CMD)
- Add PowerShell functions to your `$PROFILE` (for PowerShell)
- Add `%USERPROFILE%\bin` to your User `PATH` automatically

**Restart your terminal** after installation.

---

## ⚡ Alias Reference

### Terraform

| Alias | Command |
|-------|---------|
| `tf`  | `terraform` |
| `tfi` | `terraform init` |
| `tfp` | `terraform plan` |
| `tfa` | `terraform apply --auto-approve` |
| `tfd` | `terraform destroy --auto-approve` |
| `tfv` | `terraform validate` |
| `tff` | `terraform fmt` |

### Git

| Alias  | Command |
|--------|---------|
| `g`    | `git` |
| `gs`   | `git status` |
| `ga`   | `git add` |
| `gc`   | `git commit` |
| `gp`   | `git push` |
| `gl`   | `git pull` |
| `gb`   | `git branch` |
| `gco`  | `git checkout` |
| `gd`   | `git diff` |
| `glog` | `git log --oneline` |

---

## 📁 Project Structure

```
install-dev-aliases/
├── scripts/
│   ├── install.cmd       # CMD installer
│   └── install.ps1       # PowerShell installer
├── docs/
│   └── aliases-reference.md   # full cheat sheet
├── .gitattributes
├── CONTRIBUTING.md
└── README.md
```

---

## 🤝 Contributing

Want to add Docker, kubectl, AWS CLI, or other aliases? See [CONTRIBUTING.md](CONTRIBUTING.md).

---

## 📄 License

MIT — free to use and share.
