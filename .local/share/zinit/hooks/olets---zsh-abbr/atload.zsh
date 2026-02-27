() {
    (( ${+functions[abbr]} )) || return
    (( ${+functions[_abbr_original]} )) && return
    (( ${+functions[_abbr_refresh_cache]} )) || return
    functions -c abbr _abbr_original
    abbr() {
        (( ${@[(I)load]} )) && _abbr_refresh_cache
        _abbr_original $@
    }
    return 0
}
