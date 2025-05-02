# My Personal Dotfiles

Keeping my terminal, editor, and Git configs in one place—symlinked into `~` with [GNU Stow](https://www.gnu.org/software/stow/).

---

## 🔍 What’s Inside

- **dotfiles/** → `~/*`
- **scripts/** → helper scripts (not stowed)  
- **install.sh** → bootstrap installer  
- **needs.txt** → list of system packages to install  

Each folder is a “package”: running `stow bash` makes `bash/.bashrc → ~/.bashrc`, and so on.

---

## 🚀 Quick Start

```bash
# 1. Clone
git clone https://github.com/smarteist/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Bootstrap
./install.sh # stow all packages
# or, target specific ones:
./install.sh dotfiles
