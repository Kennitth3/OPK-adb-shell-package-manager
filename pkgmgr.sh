#!/data/local/tmp/bash
# Simple ADB Package Manager
# Usage:
#   ./pkgmgr.sh install <name> <url>
#   ./pkgmgr.sh remove <name>
#   ./pkgmgr.sh list
#   ./pkgmgr.sh help

PKG_DIR="/data/local/tmp/pkg"
BIN_DIR="/data/local/tmp/bin"

mkdir -p "$PKG_DIR" "$BIN_DIR"

install_pkg() {
    NAME="$1"
    URL="$2"

    if [ -z "$NAME" ] || [ -z "$URL" ]; then
        echo "Usage: $0 install <name> <url>"
        exit 1
    fi

    echo "[*] Installing $NAME from $URL..."

    TMPFILE="/data/local/tmp/${NAME}.pkg"
    /data/local/tmp/curl -L "$URL" -o "$TMPFILE" || {
        echo "Download failed!"
        exit 1
    }

    PKG_PATH="$PKG_DIR/$NAME"
    mkdir -p "$PKG_PATH"

    case "$TMPFILE" in
        *.tar.gz|*.tgz) tar -xzf "$TMPFILE" -C "$PKG_PATH" ;;
        *.tar.bz2) tar -xjf "$TMPFILE" -C "$PKG_PATH" ;;
        *.zip) unzip -o "$TMPFILE" -d "$PKG_PATH" ;;
        *) echo "Unknown format"; rm -f "$TMPFILE"; exit 1 ;;
    esac

    rm -f "$TMPFILE"

    # Symlink binaries to BIN_DIR
    for f in "$PKG_PATH"/bin/*; do
        [ -f "$f" ] && ln -sf "$f" "$BIN_DIR/$(basename "$f")"
    done

    echo "[+] $NAME installed"
}

remove_pkg() {
    NAME="$1"
    if [ -z "$NAME" ]; then
        echo "Usage: $0 remove <name>"
        exit 1
    fi

    echo "[*] Removing $NAME..."
    rm -rf "$PKG_DIR/$NAME"

    # Remove symlinks from BIN_DIR
    find "$BIN_DIR" -type l -exec sh -c 'target=$(readlink "{}"); case "$target" in *"/'$NAME'/"*) rm -f "{}";; esac' \;

    echo "[-] $NAME removed"
}

list_pkgs() {
    echo "Installed packages:"
    ls "$PKG_DIR"
}

show_help() {
    echo "ADB Package Manager"
    echo "Usage:"
    echo "  $0 install <name> <url>   - Install package"
    echo "  $0 remove <name>          - Remove package"
    echo "  $0 list                   - List installed packages"
    echo "  $0 help                   - Show this message"
}

case "$1" in
    install) shift; install_pkg "$@" ;;
    remove) shift; remove_pkg "$@" ;;
    list) list_pkgs ;;
    help|*) show_help ;;
esac

