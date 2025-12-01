sdk() {
    unfunction sdk
    source ${SDKMAN_DIR:-$HOME/.sdkman}/bin/sdkman-init.sh
    sdk $@
}
