z() {
    if (( ! ${+functions[zshz]} )) {
        print "Error: zshz not found." >&2
        return 1
    }

    if (( $# == 0 )) {
        zshz $HOME
        return 0
    }

    local is_project_mode=0
    case $1 {
        (-) (( ${#OLDPWD} )) && zshz $OLDPWD;;
        (-l|--list) zshz;;
        (p|p/*) is_project_mode=1;;
        (*) zshz $@;;
    }
    return_code=$?
    (( ! is_project_mode )) && return $return_code

    local proj=${ZSHZ_PROJ:-$HOME/project}
    if [[ ! -d $proj ]] {
        print "Error: projects directory '$proj' does not exist." >&2
        return 1
    }
    if [[ $1 == "p" ]] {
        zshz $proj
        return
    }

    local -a dirs
    dirs=($proj/*(/N))
    if [[ -z $dirs ]] {
        print "Error: projects directory '$proj' is empty." >&2
        return 1
    }
    dirs=(${(@oi)dirs:t})

    local choice
    choice=$(fzf \
        --color=fg:blue,fg+:green \
        --height=15 \
        --layout=reverse \
        --border \
        --with-nth=1 \
        --delimiter='\t' \
        --prompt="Select project: " \
        --query=${1:2} \
        --preview "eza --sort=type --time-style=long-iso \
            --color=always --color-scale=age --long $proj/{}" \
        --preview-window=right:70% \
        --select-1 \
        <<< "${(F)dirs}"
    )
    [[ -z $choice ]] || zshz $proj/$choice
    return
}

() {
    (( ${+functions[zshz]} )) || return
    (( ${+_comps} )) && _comps[zshz]=_files
    (( ${+aliases[z]} )) && unalias z
    return 0
}
