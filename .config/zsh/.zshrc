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

        # $XDG_DATA_HOME/{ghcup,cargo}/env

        /usr/share/doc/pkgfile/command-not-found.zsh
    )

    for config_file ($config_files) {
        [[ -f $config_file && -r $config_file ]] || continue
        source $config_file
    }
    return 0
}

() {
    local -a PROJ_DIRS=(
        "/mnt/c/Users/7/DevEcoStudioProjects"
        "/mnt/d/Project"
    )
    (( ${PROJ_DIRS[(Ie)${PWD:h}]} )) || return 0

    local source_path real_path
    for source_path ($HOME/project/*(N)) {
        [[ -L $source_path ]] || continue
        real_path=${source_path:A}
        if [[ $real_path == $PWD ]]; then
            cd $source_path
            return 0
        fi
    }
    return 0
}

# unsetopt XTRACE
# exec 2>&3 3>&-
