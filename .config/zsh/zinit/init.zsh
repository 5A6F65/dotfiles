typeset -gAH ZINIT
ZINIT[HOME_DIR]=${XDG_DATA_HOME:-${HOME}/.local/share}/zinit
ZINIT[BIN_DIR]=${ZINIT[HOME_DIR]}/zinit.git
ZINIT[ZCOMPDUMP_PATH]=${ZSH_COMPDUMP:-${XDG_CACHE_HOME:-$HOME/.cache}/.zcompdump}
ZINIT[NO_ALIASES]=1
ZINIT[CLONE_DEPTH]=1

# Optimize loading based on usage context
if (( ${+functions[_p9k_instant_prompt_precmd_first]} )) || [[ $ZSH_EXECUTION_STRING == exit ]] {
    # Fast mode: instant prompt enabled or only exiting
    ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1
    ZINIT[COMPINIT_OPTS]='-C'
    ZINIT[LOAD_OPTS]="depth=${ZINIT[CLONE_DEPTH]} wait lucid light-mode nocd"
} else {
    # Safe mode: slow down loading to prevent unexpected behavior
    ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=0
    ZINIT[COMPINIT_OPTS]=''
    ZINIT[COMPINIT_OPTS]='-C'
    ZINIT[LOAD_OPTS]="depth=${ZINIT[CLONE_DEPTH]}"
}

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

# Wrap compinit
zicompinit() {
    (( ${+ZINIT[_ZICOMPINIT_DONE]} )) && return

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

    ZINIT[_ZICOMPINIT_DONE]=1
}

# Allow asynchronous initialization of the completion system
zinit ${=ZINIT[LOAD_OPTS]} for \
    atinit='zicompinit && zicdreplay' zdharma-continuum/null

# Load zinit annexes
zinit ${=ZINIT[LOAD_OPTS]} for \
    _local/zinit-annex-external-hook

# Load configurations
source ${ZDOTDIR:-$HOME}/zinit/themes/p10k.zsh
source ${ZDOTDIR:-$HOME}/zinit/frameworks/omz.zsh
source ${ZDOTDIR:-$HOME}/zinit/plugins/load.zsh
