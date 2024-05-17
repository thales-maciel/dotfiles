typeset -U PATH path

export ZDOTDIR="$HOME/.config/zsh"

# auto activate python venvs
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

export LANGUAGE=en_US.UTF-8

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"

export CARGO_HOME="$XDG_DATA_HOME/cargo"

export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="$XDG_CACHE_HOME/ansible/galaxy_cache"

export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

export NUGET_PACKAGES="$XDG_DATA_HOME/nuget/packages"

export GHCUP_USE_XDG_DIRS=true

export GNUPGHOME="$XDG_DATA_HOME/gnupg"

export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export STACK_XDG=1

export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc 
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc 

export ZPLUG_HOME="$XDG_DATA_HOME/zplug"

# Default Apps
export TERMINAL="alacritty"
export EDITOR="nvim"
export VISUAL="nvim"

# Other program settings:
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Disable files
export LESSHISTFILE=-

path=(~/.local/bin ~/.local/share/cargo/bin ~/scripts ~/.local/share/gem/ruby/2.7.0/bin ~/.dotnet/tools $path)
QT_QPA_PLATFORMTHEME=qt5ct
