# -----------------
# Zsh configuration
# -----------------
export PATH="$HOME/.local/bin:$PATH"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------
#export PATH="$PATH:/opt/nvim-linux64/bin"
export PYENV_ROOT="$HOME/.pyenv"
# Use degit instead of git as the default tool to install and update modules.
zstyle ':zim:zmodule' use 'degit'


# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1


# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)


ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh


zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key


#remove underline#
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.9-dev/bin/python"
# added by Pew
source "$(pew shell_config)"

export EDITOR='/bin/nvim'
export LANG=en_US.UTF-8

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
# ----- Bat (better cat) -----
# FIXME: check how to install theme in system
export BAT_THEME="Coldark-Dark"



# aliases
alias cl="clear"
alias vi='nvim'
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"

# ---- Eza (better ls) -----
alias ls="eza --icons=always"
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias cd="z"
alias la=tree
alias cat=bat

# Git
alias gc='git commit'
alias gca="git commit -a -m"
alias gp="git push"
alias gpu="git pull"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'
alias gf='git fixup'
alias lg='lazygit'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"


# ---- TheFuck -----
# thefuck alias
# eval $(thefuck --alias)
# eval $(thefuck --alias fk)

#alias ifzf="$(fzf -m --preview="bat --color=always {}")"

# ----- FZF ----
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ---- YAZI ---
alias yz="~/dotfiles/.config/yazi/target/release/yazi"

# -- Odoo ---
alias kodoo="kill $(lsof -t -i:8069)"

# Load .env file if it exists
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PATH=~/.npm-global/bin:$PATH
