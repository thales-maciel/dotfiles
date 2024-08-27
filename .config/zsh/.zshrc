WARN() {
  echo -e "\033[1;33mWARNING!\033[0m $1"
}

source_if_exists() {
  local filepath=$(eval echo "$1")
  if [ -f "$filepath" ]; then
    source "$filepath"
  else
    if [ ! -z "$2" ]; then
      WARN $2
    fi
  fi
}

export PATH=/usr/local/go/bin:$PATH

if [[ "$TERM" != emacs ]]; then
  [[ -z "$terminfo[kdch1]" ]] || bindkey -M emacs "$terminfo[kdch1]" delete-char
  [[ -z "$terminfo[khome]" ]] || bindkey -M emacs "$terminfo[khome]" beginning-of-line
  [[ -z "$terminfo[kend]" ]] || bindkey -M emacs "$terminfo[kend]" end-of-line
  [[ -z "$terminfo[kich1]" ]] || bindkey -M emacs "$terminfo[kich1]" overwrite-mode
  [[ -z "$terminfo[kdch1]" ]] || bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
  [[ -z "$terminfo[khome]" ]] || bindkey -M vicmd "$terminfo[khome]" vi-beginning-of-line
  [[ -z "$terminfo[kend]" ]] || bindkey -M vicmd "$terminfo[kend]" vi-end-of-line
  [[ -z "$terminfo[kich1]" ]] || bindkey -M vicmd "$terminfo[kich1]" overwrite-mode

  [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" vi-up-line-or-history
  [[ -z "$terminfo[cuf1]" ]] || bindkey -M viins "$terminfo[cuf1]" vi-forward-char
  [[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" vi-up-line-or-history
  [[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" vi-down-line-or-history
  [[ -z "$terminfo[kcuf1]" ]] || bindkey -M viins "$terminfo[kcuf1]" vi-forward-char
  [[ -z "$terminfo[kcub1]" ]] || bindkey -M viins "$terminfo[kcub1]" vi-backward-char

  # ncurses fogyatekos
  [[ "$terminfo[kcuu1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" vi-up-line-or-history
  [[ "$terminfo[kcud1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" vi-down-line-or-history
  [[ "$terminfo[kcuf1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcuf1]/O/[}" vi-forward-char
  [[ "$terminfo[kcub1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcub1]/O/[}" vi-backward-char
  [[ "$terminfo[khome]" == "^[O"* ]] && bindkey -M viins "${terminfo[khome]/O/[}" beginning-of-line
  [[ "$terminfo[kend]" == "^[O"* ]] && bindkey -M viins "${terminfo[kend]/O/[}" end-of-line
  [[ "$terminfo[khome]" == "^[O"* ]] && bindkey -M emacs "${terminfo[khome]/O/[}" beginning-of-line
  [[ "$terminfo[kend]" == "^[O"* ]] && bindkey -M emacs "${terminfo[kend]/O/[}" end-of-line
fi

# History
HISTFILE=$XDG_CACHE_HOME/zsh/history
mkdir -p $(dirname "$HISTFILE")
HISTSIZE=20000
SAVEHIST=20000
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt histignorealldups

LS_COLORS=$LS_COLORS:'ow=01;34:' ; export LS_COLORS

# Aliases
source_if_exists ${ZDOTDIR:-~}/.aliases

# Emacs mode
# bindkey -e

# vi mode
bindkey -v

# Prompt
setopt prompt_subst
autoload -U colors && colors

# Load vcs_info
autoload -Uz vcs_info
precmd() {
  vcs_info 

  # Default branch color (magenta)
  local branch_color='%F{white}'

  # Check for unpulled changes
  local unpulled_count=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)
  
  # Check for unpushed changes
  local unpushed_count=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)

  # Determine branch color based on unpulled/unpushed changes
  if [[ -n $unpulled_count && $unpulled_count -gt 0 ]]; then
    branch_color='%F{red}'
  elif [[ -n $unpushed_count && $unpushed_count -gt 0 ]]; then
    branch_color='%F{yellow}'
  fi

  # Check if working dir is dirty
  local git_dirty=''
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    git_dirty='*'
  fi

  # Set vcs_info_msg_0_ with the colored branch name and indicators
  vcs_info_msg_0_="${branch_color}${vcs_info_msg_0_}${git_dirty}%f"

  # Add markers for unpulled/unpushed changes
  if [[ -n $unpulled_count && $unpulled_count -gt 0 ]]; then
    vcs_info_msg_0_+="%F{red}↓$unpulled_count%f"
  fi

  if [[ -n $unpushed_count && $unpushed_count -gt 0 ]]; then
    vcs_info_msg_0_+="%F{yellow}↑$unpushed_count%f"
  fi
}

# Configure vcs_info with zstyle
zstyle ':vcs_info:git:*' enable git
zstyle ':vcs_info:git*' formats '%b'
zstyle ':vcs_info:*' actionformats '%F{yellow}(%b|%a)%f'

PROMPT='%B%F{cyan}%1~%f%b ${vcs_info_msg_0_}
%B%(?.%F{green}λ%f%b.%F{red}λ%f%b) '






source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source_if_exists /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source_if_exists /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source_if_exists /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Case-insensitive matching when tabbing
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#fzf
source_if_exists '/usr/share/fzf/key-bindings.zsh'
source_if_exists '/usr/share/fzf/completion.zsh'

# docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# google cloud sdk
source_if_exists '~/google-cloud-sdk/path.zsh.inc'
source_if_exists '~/google-cloud-sdk/completion.zsh.inc'

# golang
export PATH="/usr/local/go/bin:$PATH"
export PATH="/home/thales/.local/share/go/bin:$PATH"

# ghcup
source_if_exists '~/.ghcup/env'
source_if_exists '/home/thales/.local/share/ghcup/env' # ghcup-env

# pnpm
export PNPM_HOME="/home/thales/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# sdkman
export SDKMAN_DIR="/home/thales/.sdkman"
source_if_exists '/home/thales/.sdkman/bin/sdkman-init.sh'

# bit
export PATH="$PATH:/home/thales/bin"

# fnm
export PATH="/home/thales/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd)"

if command -v nix-env > /dev/null 2>&1; then
  export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"
fi

# opam configuration
[[ ! -r /home/thales/.opam/opam-init/init.zsh ]] || source /home/thales/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# Turso
export PATH="/home/thales/.turso:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
