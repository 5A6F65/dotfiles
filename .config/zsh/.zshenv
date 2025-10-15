export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_BIN_HOME=$HOME/.local/bin

export GHCUP_USE_XDG_DIRS=true

export GHC_ENVIRONMENT=$XDG_DATA_HOME/ghc/env/default

export CARGO_HOME=$XDG_DATA_HOME/cargo

export CABAL_DIR=$XDG_DATA_HOME/cabal

export DOTNET_CLI_HOME=$XDG_DATA_HOME/dotnet

export GNUPGHOME=$XDG_DATA_HOME/gnupg

export GOPATH=$XDG_DATA_HOME/go

export LESSHISTFILE=$XDG_STATE_HOME/lesshst

export NODE_REPL_HISTORY=$XDG_STATE_HOME/node_repl_history

export NPM_CONFIG_INIT_MODULE=$XDG_CONFIG_HOME/npm/config/npm-init.js
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_TMP=$XDG_RUNTIME_DIR/npm

export NVM_DIR=$XDG_DATA_HOME/nvm

export RUSTUP_HOME=$XDG_DATA_HOME/rustup

export SDKMAN_DIR=$XDG_DATA_HOME/sdkman

export STACK_ROOT=$XDG_DATA_HOME/stack
export STACK_XDG=true

export QUICKLISP_HOME=$XDG_DATA_HOME/quicklisp
export QUICKLISP_CACHE=$XDG_CACHE_HOME/quicklisp

export DOTNET_CLI_HOME=$XDG_DATA_HOME/dotnet

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx"

export EZA_COLORS="da=36"

export LESS='-R --mouse'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_mb=$'\e[1;31mm'   # begin blinking
export LESS_TERMCAP_md=$'\e[1;36m'    # begin bold
export LESS_TERMCAP_us=$'\e[1;332m'   # begin underline
export LESS_TERMCAP_so=$'\e[1;44;33m' # begin standout-mode - info box
export LESS_TERMCAP_me=$'\e[0m'       # end mode
export LESS_TERMCAP_ue=$'\e[0m'       # end underline
export LESS_TERMCAP_se=$'\e[0m'       # end standout-mode

export NODE_OPTIONS='--disable-warning=ExperimentalWarning'

export DELTA_FEATURES='diff-so-fancy'

path=(/snap/bin $path)

path=(/usr/local/texlive/2024/bin/x86_64-linux $path)
manpath=(/usr/local/texlive/2024/texmf-dist/doc/man $manpath)
infopath=(/usr/local/texlive/2024/texmf-dist/doc/info $infopath)

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
path=($JAVA_HOME/bin $path)

export ANDROID_HOME=$HOME/android/sdk
path=($ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools $path)

export GOPATH=$HOME/go
path=($GOPATH/bin $path)

path=({$XDG_DATA_HOME/{ghcup,cargo},$XDG_CONFIG_HOME/cabal}/bin $path)

path=($HOME/.gem/bin $path)

path=($XDG_BIN_HOME $path)
