#  Support
## Aliases Reference
See the [REFERENCE.md](docks/README.md) file for detailed usage.


Complete reference for all aliases installed by **dev-aliases**, including descriptions and real-world workflow examples.

---

## Terraform

| Alias  | Full Command | Description |
|--------|-------------|-------------|
| `tf`   | `terraform` | Base Terraform command |
| `tfi`  | `terraform init` | Initialize a working directory and download providers |
| `tfp`  | `terraform plan` | Preview what changes will be applied |
| `tfa`  | `terraform apply --auto-approve` | Apply changes without a confirmation prompt |
| `tfd`  | `terraform destroy --auto-approve` | Destroy all resources without a confirmation prompt |
| `tfv`  | `terraform validate` | Check configuration files for syntax errors |
| `tff`  | `terraform fmt` | Auto-format `.tf` files to canonical style |
| `tfo`  | `terraform output` | Display output values defined in the configuration |
| `tfs`  | `terraform show` | Inspect the current state or a saved plan file |
| `tfws` | `terraform workspace` | List, create, or switch Terraform workspaces |

### Common Terraform Workflows

```bash
# Standard deploy flow
tfi                   # initialize directory
tfv                   # validate configuration
tfp                   # preview changes
tfa                   # apply changes

# Inspect state
tfs                   # show current state
tfo                   # show output values

# Workspace management
tfws list             # list all workspaces
tfws new staging      # create a new workspace
tfws select staging   # switch to a workspace

# Teardown
tfd                   # destroy all resources
```

---

## Git

| Alias  | Full Command | Description |
|--------|-------------|-------------|
| `g`    | `git` | Base Git command |
| `gs`   | `git status` | Show the state of the working tree and staging area |
| `ga`   | `git add` | Stage changes for the next commit |
| `gc`   | `git commit` | Record staged changes with a message |
| `gp`   | `git push` | Push local commits to the remote repository |
| `gl`   | `git pull` | Fetch and integrate changes from the remote |
| `gb`   | `git branch` | List, create, rename, or delete branches |
| `gco`  | `git checkout` | Switch branches or restore working tree files |
| `gd`   | `git diff` | Show differences between working tree and index |
| `glog` | `git log --oneline` | Display a compact, one-line commit history |
| `gst`  | `git stash` | Temporarily save uncommitted changes |
| `gstp` | `git stash pop` | Re-apply the most recently stashed changes |
| `grs`  | `git restore` | Discard changes in the working directory |
| `grss` | `git restore --staged` | Remove files from the staging area |
| `gm`   | `git merge` | Merge a branch into the currently active branch |
| `grb`  | `git rebase` | Reapply commits on top of another base branch |
| `grt`  | `git remote -v` | List all configured remote repositories with URLs |
| `gcl`  | `git clone` | Clone a remote repository to your local machine |

### Common Git Workflows

```bash
# Daily commit flow
gs                          # check status
ga .                        # stage all changes
gc -m "feat: add feature"   # commit with message
gp                          # push to remote

# Feature branch workflow
gb feature/my-feature       # create new branch
gco feature/my-feature      # switch to branch
gs                          # verify status
ga .
gc -m "feat: my feature"
gp                          # push branch

# Stash and switch context
gst                         # stash current work
gco main                    # switch to main
gl                          # pull latest
gco feature/my-feature      # switch back
gstp                        # restore stashed work

# Undo mistakes
grs file.txt                # discard changes in file
grss file.txt               # unstage a staged file
glog                        # review commit history
```

---

## Coming Soon

| Tool    | Planned Aliases |
|---------|----------------|
| Docker  | `d` `dps` `dex` `dlogs` `dstop` `drm` `dimg` `dbuild` |
| kubectl | `k` `kgp` `kgs` `kgn` `kdesc` `klogs` `kex` `kapply` |
| AWS CLI | `aws-id` `aws-region` `aws-profile` and more |

Want to contribute one of these? See [CONTRIBUTING.md](../CONTRIBUTING.md).
