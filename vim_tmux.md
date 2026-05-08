
---

# VIM

Quit VIM!

**:q + ENTER**

Force Quit VIM!

**:q! + ENTER**

Write & Quite VIM

**:wq + ENTER**

## Normal Mode

**u** undo

**CTRL+r** redo

**h** move one character left

**j** move one row down

**k** move one row up

**l** move one character right

**zz** center the page!

**w** move to beginning of next word

**W** move to beginning of next word after a whitespace

**b** move to previous beginning of word

**B** move to beginning of previous word before a whitespace

**e** move to end of word

**E** move to end of word before a whitespace

**0** move to the beginning of the line

**$** move to the end of the line



**yy** yank line ≈ copy line

**dd** cut the line (yank + delete)

**x** cut the char (yank + delete)

**p** paste before

**P** paste after

## Insert mode

**Esc** Exit from current mode and enter to the `Normal` mode.

**i** Enter insert mode.

**a** Enter apend mode.

**I** for prepend insert to the line.

**a** Enter append insert mode.

**A** for append insert to the line.

**o** Enter ordered new line insert mode.

**O** Enter ordered new line insert mode above.

## Visual Mode

**v** Enter visual mode, this will also mark a starting selection point

**V** Enter visual line mode, this will make text selections by line

**y** To yank selection

**d** To cut selection

**gg** Go to start of file

**G** Go to end of file

---

# NEOVIM LSP

## Commands

**:checkhealth lsp** Run LSP health check

**:echo exepath('')** Check if server executable exists

**:lua vim.cmd.edit(vim.lsp.get_log_path())** Open LSP log file

**:lua vim.lsp.set_log_level('debug')** Set log level to debug

## Normal Mode (v0.10 / v0.11 Defaults)

**K** Show documentation for symbol under cursor

**[d** Move to previous diagnostic

**]d** Move to next diagnostic

**CTRL+w + d** Open floating window with line diagnostics

**grn** Rename all references of symbol

**gra** Show available code actions

**grr** List all references of symbol

**gri** List all implementations for symbol

**gO** List all symbols in current buffer

**CTRL+]** Jump to definition

**CTRL+t** Jump back from definition

## Insert Mode

**CTRL+x + CTRL+o** Trigger smart code completions (omnifunc)

**CTRL+s** Display function signature

## Visual Mode

**gq** Format selected code via language server

---

# TMUX

Create Numeric Tmux Session : `tmux`

Create Named Tmux Session : `tmux new -s <name>`

Activate Tmux Shortcuts : **CTRL+B**

Enter copy/scrollback mode: **CTRL+B** + [

Divide Horizontally :  **CTRL+B** + %

Divide Vertically :  **CTRL+B** + "

Exit CLI : `exit`

Create Window : **CTRL+B** + **c**

Switch to window number # : **CTRL+B** + **<#>**

Rename Current Window : **CTRL+B** + **,**

Find Window : **CTRL+B** + **'**

Detach from session: **CTRL+B** + **d**

List all bg sessions: `tmux ls`

Attach to session: `tmux attach -t <#>`

Rename session: `tmux rename-session -t <target> <newname>`

Kill session: `tmux kill-session -t <target>`