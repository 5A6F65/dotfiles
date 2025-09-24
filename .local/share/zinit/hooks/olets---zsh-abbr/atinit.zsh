ABBR_DEFAULT_BINDINGS=0
ABBR_SET_EXPANSION_CURSOR=1
ABBR_GET_AVAILABLE_ABBREVIATION=1
ABBR_LOG_AVAILABLE_ABBREVIATION=1
ABBR_LOG_AVAILABLE_ABBREVIATION_AFTER=1
ABBR_AUTOLOAD=0

() {
    local abbr_cache_dir abbr_cache_file
    local abbr_config_dir abbr_config_file
    local -a abbr_config_files

    abbr_config_dir=${XDG_CONFIG_HOME:-$HOME/.config}/zsh-abbr
    abbr_cache_dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh-abbr
    abbr_cache_file=$abbr_cache_dir/current
    [[ -d $abbr_config_dir ]] || return
    [[ -d $abbr_cache_dir ]] || mkdir -p $abbr_cache_dir || return
    [[ ! -f $abbr_cache_file ]] || : >| $abbr_cache_file || return

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

    ABBR_USER_ABBREVIATIONS_FILE=$abbr_cache_file
    return 0
}
