ziplugins=(
    # Make sure fzf-tab is the last plugin to bind "^I"
    # and before plugins which will wrap widgets
    Aloxaf/fzf-tab

    zdharma-continuum/fast-syntax-highlighting
    zdharma-continuum/history-search-multi-word

    # atload='zvm_init' jeffreytse/zsh-vi-mode

    # Make sure that zsh-abbr is after fast-syntax-highlighting
    # and before zsh-autosuggestions when set ZSH_AUTOSUGGEST_MANUAL_REBIND
    olets/zsh-abbr
    atload='_abbr_log_available_abbreviation'
        olets/zsh-autosuggestions-abbreviations-strategy
    5A6F65/fast-abbr-highlighting

    atload='_zsh_autosuggest_start' zsh-users/zsh-autosuggestions
    blockf atpull='zinit creinstall -q $dir' zsh-users/zsh-completions

    atload='zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}'
        eval='dircolors -b LS_COLORS' trapd00r/LS_COLORS

    atload='_zshz_precmd' agkozak/zsh-z
    # agkozak/zhooks

    # atload='_flush_ysu_buffer' MichaelAquilina/zsh-you-should-use

    # z-shell/zsh-cmd-architect
)
zinit wait light-mode for $ziplugins
