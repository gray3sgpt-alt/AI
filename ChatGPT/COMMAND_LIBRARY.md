# Command Library

Reusable shell commands, one-liners, and workflows.

## Safety defaults
- Use `set -euo pipefail` in scripts
- Prefer `rsync` over `cp` for big moves
- Always dry-run (`-n`) first when possible

## Useful patterns

### Search text quickly
- ripgrep: `rg -n "pattern" path/`
- find files: `fd "name" path/` (or `find path -name ...`)

### Capture command output
- overwrite: `cmd > file.txt`
- append: `cmd >> file.txt`
- view + save: `cmd | tee file.txt`
- append + view: `cmd | tee -a file.txt`

### Folder snapshot
- `tree -a -L 3 path/ > snapshot.txt`
