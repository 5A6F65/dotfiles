typeset -gAH ZINIT
ZINIT[HOME_DIR]=${XDG_DATA_HOME:-${HOME}/.local/share}/zinit
ZINIT[BIN_DIR]=${ZINIT[HOME_DIR]}/zinit.git
ZINIT[ZCOMPDUMP_PATH]=${ZSH_COMPDUMP:-${XDG_CACHE_HOME:-$HOME/.cache}/.zcompdump}
ZINIT[NO_ALIASES]=1

# Install zinit if not present
if [[ ! -d ${ZINIT[BIN_DIR]} ]] {
    print -P "%F{004}Installing ZINIT…%f"
    mkdir -p ${ZINIT[BIN_DIR]%/*}
    chmod g-rwX ${ZINIT[BIN_DIR]%/*}
    git clone --depth 1 https://github.com/zdharma-continuum/zinit.git ${ZINIT[BIN_DIR]}
}

# Load zinit
source ${ZINIT[BIN_DIR]}/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

if (( ${+functions[_p9k_instant_prompt_precmd_first]} )) || [[ $ZSH_EXECUTION_STRING == exit ]] {
    # Optimized mode: skip unnecessary disk accesses and omit new-function check
    # when the instant prompt is active or executing only exit
    ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1
    ZINIT[COMPINIT_OPTS]='-C'
} else {
    # Debug mode: disable light and turbo modes for clearer tracing
    ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=0
    functions -c zinit .zinit-original
    zinit() {
        .zinit-original ${${@:#(light-mode|wait*)}//(#s)light(#e)/load}
    }
}

# Load zinit annexes
zinit depth=1 nocd light-mode for \
    zdharma-continuum/zinit-annex-default-ice \
    _local/z-a-external-hook \
    NICHOLAS85/z-a-eval
zinit default-ice -q depth=1 nocd lucid

# Load theme
source ${ZDOTDIR:-$HOME}/themes/p10k.zsh
zinit light-mode for romkatv/powerlevel10k

# Wrap compinit
zicompinit() {
    # Initialize completion system
    setopt extendedglob
    autoload -Uz compinit
    local compinit_dump=${ZINIT[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}
    local -a compinit_opts=(${(Q@)${(z@)ZINIT[COMPINIT_OPTS]}})
    # Rebuild cache if older than 24 hours
    (( ${compinit_opts[(I)-C]} )) \
        && [[ ! -f $compinit_dump || -n $compinit_dump(#qN.mh+24) ]] \
        && compinit_opts=(${compinit_opts:#-C})
    # Follow the original zicompinit options order
    compinit -d $compinit_dump $compinit_opts

    # Load specific command completions
    (( ${+commands[jj]} )) && source <(COMPLETE=zsh jj)
}

# Allow asynchronous initialization of the completion system
zinit wait light-mode for \
    atinit='zicompinit && zicdreplay' zdharma-continuum/null

# Load libraries
zinit wait for OMZL::{completion,key-bindings}.zsh

# Load plugins
source ${ZDOTDIR:-$HOME}/zinit/plugins/main.zsh
source ${ZDOTDIR:-$HOME}/zinit/plugins/omz.zsh
source ${ZDOTDIR:-$HOME}/zinit/plugins/lazy.zsh
