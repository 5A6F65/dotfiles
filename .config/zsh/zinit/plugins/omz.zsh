.zinit-fix-omz-plugin() {
    [[ -d $dir/._zinit ]] || return 1

    local pluginid
    local file

    for pluginid (${dirname#OMZ::plugins/} ${dirname#OMZP::}) {
        [[ $pluginid != $dirname ]] && break
    }
    (( $? )) && return 1

    print "Fixing $dirname..."
    rm -rf $dir/ohmyzsh
    git clone --quiet --no-checkout --depth=1 --filter=tree:0 \
        https://github.com/ohmyzsh/ohmyzsh "$dir/ohmyzsh"
    git -C "$dir/ohmyzsh" sparse-checkout set --no-cone "plugins/$pluginid"
    git -C "$dir/ohmyzsh" checkout --quiet 2>/dev/null # --quiet doesn't seem to work here?
    for file ($dir/ohmyzsh/plugins/$pluginid/*~(.gitignore|*.plugin.zsh)(D)) {
        [[ ${file:t} != "README.md" ]] && print "Copying ${file:t}..."
        cp -R $file $dir/${file:t}
    }
    rm -rf $dir/ohmyzsh
    return 0
}

zinit wait for \
    as='completion' OMZP::rust/_rustc \
    OMZP::{ssh-agent,sudo}

zinit wait atclone='.zinit-fix-omz-plugin' atpull='%atclone' for \
    atload='unalias x' OMZP::extract \
    OMZP::colored-man-pages
