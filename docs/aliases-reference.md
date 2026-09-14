# Aliases Reference

Quick cheat sheet for all installed aliases.

---

## Terraform

| Alias | Full Command | Description |
|-------|-------------|-------------|
| `tf`  | `terraform` | Base terraform command |
| `tfi` | `terraform init` | Initialize working directory |
| `tfp` | `terraform plan` | Preview changes |
| `tfa` | `terraform apply --auto-approve` | Apply changes without prompt |
| `tfd` | `terraform destroy --auto-approve` | Destroy resources without prompt |
| `tfv` | `terraform validate` | Validate configuration files |
| `tff` | `terraform fmt` | Format configuration files |

### Common Terraform Workflows

```bash
# New project setup
tfi               # terraform init
tfv               # terraform validate
tfp               # terraform plan
tfa               # terraform apply --auto-approve

# Cleanup
tfd               # terraform destroy --auto-approve
```

---

## Git

| Alias  | Full Command | Description |
|--------|-------------|-------------|
| `g`    | `git` | Base git command |
| `gs`   | `git status` | Show working tree status |
| `ga`   | `git add` | Stage changes |
| `gc`   | `git commit` | Commit staged changes |
| `gp`   | `git push` | Push to remote |
| `gl`   | `git pull` | Pull from remote |
| `gb`   | `git branch` | List / manage branches |
| `gco`  | `git checkout` | Switch branches or restore files |
| `gd`   | `git diff` | Show unstaged changes |
| `glog` | `git log --oneline` | Compact commit history |

### Common Git Workflows

```bash
# Daily commit flow
gs                        # git status
ga .                      # git add .
gc -m "your message"      # git commit -m "your message"
gp                        # git push

# Branch workflow
gb feature/my-feature     # git branch feature/my-feature
gco feature/my-feature    # git checkout feature/my-feature
glog                      # git log --oneline
```

---

## Coming Soon

- Docker aliases (`d`, `dps`, `dex`, `dlogs`, ...)
- kubectl aliases (`k`, `kgp`, `kgs`, `kdesc`, ...)
- AWS CLI aliases
