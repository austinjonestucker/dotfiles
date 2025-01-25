# Disable auto titling
DISABLE_AUTO_TITLE="true"
precmd () {print -Pn "\e]0;%~\a"}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# fix wsl time sync
# sudo ntpdate ntp.ubuntu.com &>/dev/null &

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Convenient aliases
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias tmux="TERM=screen-256color-bce tmux -2 -u"
# SSH with passwords, if passwords in 1Password
alias sshwp='~/ssh_login.sh'
alias der="dotenv run"
alias vim="nvim"

# Add zmv
autoload zmv

# Add thefuck
# eval $(thefuck --alias)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Mac OS only config
export HOMEBREW_HOME="/opt/homebrew"
# export HOMEBREW_HOME="/usr/local"
export MACPORTS_HOME="/opt/local"

# C Compilation
export PATH="$HOMEBREW_HOME/bin:$PATH"
export LDFLAGS="-L$HOMEBREW_HOME/lib -framework OpenGL -L/opt/X11/lib"
export CPPFLAGS="-I$HOMEBREW_HOME/include"
# export PKG_CONFIG_LIBDIR="$MACPORTS_HOME/lib/pkconfig"
export PATH=$HOMEBREW_HOME/opt/gcc/bin:$PATH
export LC_CTYPE=C
export LANG=C
export CC=clang
# export CXX=clang
# export PATH=$HOMEBREW_HOME/opt/llvm/bin:$PATH
# export ARCHFLAGS="-arch x86_64"


# Kerberos config
export PATH=$HOMEBREW_HOME/opt/krb5/bin:$PATH
export PATH=$HOMEBREW_HOME/opt/krb5/sbin:$PATH
export LDFLAGS="$LDFLAGS -L$HOMEBREW_HOME/opt/krb5/lib"
export CPPFLAGS="$CPPFLAGS -I$HOMEBREW_HOME/opt/krb5/include"
# export LDFLAGS="-L$HOMEBREW_HOME/opt/krb5/lib"
# export CPPFLAGS="-I$HOMEBREW_HOME/opt/krb5/include"

# Bison config
# export PATH="$HOMEBREW_HOME/opt/bison/bin:$PATH"

# GNUTLS config
# export PATH="$HOMEBREW_HOME/opt/gnutls/bin:$PATH"
# export LDFLAGS="-L$HOMEBREW_HOME/opt/gnutls/lib"

# OpenGL config
# export LDFLAGS="-L/opt/X11/lib"

# GPG config
export GPG_TTY=$(tty)

# Kitty config
export KITTY_CONFIG_DIRECTORY="$HOME/.config/kitty"

# Lua configuration
export DYLD_LIBRARY_PATH=$HOMEBREW_HOME/lib/

# Ruby config
# eval "$(rbenv init -)"
# export RBENV_VERSION="3.3.0"
# export RBENV_HOME="$HOME/.gem/ruby/$RBENV_VERSION"
# export PATH=$RBENV_HOME/bin:$PATH

# Postgres CLI config
export PATH="$HOMEBREW_HOME/opt/libpq/bin:$PATH"

# ODBC CLI config
# export PATH="$HOMEBREW_HOME/opt/unixodbc/bin:$PATH"
# export LDFLAGS="-L$HOMEBREW_HOME/opt/unixodbc/lib"
# export CPPFLAGS="-I$HOMEBREW_HOME/opt/unixodbc/include"

# Oracle SQL CLI config
export ORACLE_HOME=$HOME/oracle
export PATH="$PATH:$HOMEBREW_HOME/Caskroom/sqlcl/*/sqlcl/bin:"
export PATH=$PATH:$ORACLE_HOME

# Javascript config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python config
export PYENV_ROOT="$HOME/.pyenv"
export VIRTUALENVWRAPPER_PYTHON="$PYENV_ROOT/shims/python3"
command -v pyenv >/dev/null || export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper_lazy

export PATH="$PATH:$HOME/.local/bin"
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/repos

# PySpark config
# source /etc/environment
#when running spark locally, it uses 2 cores, hence local[2]
export PYSPARK_SUBMIT_ARGS="--master local[2] pyspark-shell"
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
export PYSPARK_PYTHON=python3

# export CONDA_AUTO_ACTIVATE_BASE=false
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="$PATH:/opt/miniconda3/bin"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

fpath+=${ZDOTDIR:-~}/.zsh_functions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# To customize prompt, run `p10k configure` or edit ~/Documents/dotfiles/.p10k.zsh.
[[ ! -f ~/Documents/dotfiles/.p10k.zsh ]] || source ~/Documents/dotfiles/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
