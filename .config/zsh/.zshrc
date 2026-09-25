# zmodload zsh/zprof

# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
# exec 3>&2 2> $HOME/xtrace.log
# setopt XTRACE

() {
    local config_file
    local -a config_files
    config_files=(
        ${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh
        ${ZDOTDIR:-$HOME}/custom/history.zsh
        ${ZDOTDIR:-$HOME}/zinit/init.zsh
        ${ZDOTDIR:-$HOME}/custom/{bindkey,alias,lazy}.zsh
        /usr/share/doc/pkgfile/command-not-found.zsh
    )
    for config_file (${^config_files}(-.rN)) source $config_file
    return 0
}

# unsetopt XTRACE
# exec 2>&3 3>&-
