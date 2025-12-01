() {
    (( ${+functions[abbr]} )) || return

    abbr-expand-and-redisplay() {
        abbr-expand-and-insert
        zle redisplay
    }
    zle -N abbr-expand-and-redisplay
    bindkey " " abbr-expand-and-redisplay
    bindkey "^ " magic-space
    bindkey -M isearch "^ " abbr-expand-and-insert
    bindkey -M isearch " " magic-space

    (( ${+functions[_abbr_original]} )) && return
    (( ${+functions[_abbr_refresh_cache]} )) || return
    functions -c abbr _abbr_original
    abbr() {
        (( ${@[(I)load]} )) && _abbr_refresh_cache
        _abbr_original $@
    }

    return 0
}
