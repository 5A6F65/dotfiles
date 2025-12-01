ABBR_DEFAULT_BINDINGS=0
ABBR_SET_EXPANSION_CURSOR=1
ABBR_GET_AVAILABLE_ABBREVIATION=1
ABBR_LOG_AVAILABLE_ABBREVIATION=1
ABBR_LOG_AVAILABLE_ABBREVIATION_AFTER=1
ABBR_AUTOLOAD=0

_abbr_refresh_cache() {
    emulate -LR zsh ${=${options[xtrace]:#off}:+-o xtrace}
    setopt extendedglob warncreateglobal typesetsilent noshortloops

    local abbr_config_dir abbr_config_file abbr_cache_file
    local -a abbr_config_files

    abbr_config_dir=${ABBR_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh-abbr}
    abbr_cache_file=${ABBR_CACHE_FILE:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh-abbr/current}
    [[ -d $abbr_config_dir ]] || return
    [[ -d ${abbr_cache_file:h} ]] || mkdir -p ${abbr_cache_file:h} || return
    [[ ! -e $abbr_cache_file ]] || : >| $abbr_cache_file || return

    abbr_config_files=()
    for abbr_config_file ($abbr_config_dir/commands/*(N)) {
        (( ${+commands[${abbr_config_file:t}]} )) || continue
        abbr_config_files+=($abbr_config_file)
    }
    abbr_config_files+=($abbr_config_dir/misc)

    for abbr_config_file ($abbr_config_files) {
        [[ -f $abbr_config_file && -r $abbr_config_file ]] || continue
        <$abbr_config_file
        print
    } >> $abbr_cache_file

    unsetopt warncreateglobal
    ABBR_USER_ABBREVIATIONS_FILE=$abbr_cache_file
    return 0
}

_abbr_refresh_cache
