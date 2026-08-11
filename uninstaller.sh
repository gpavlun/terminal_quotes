#!/bin/sh
set -eu

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/.local/bin"
EXECUTABLE_NAME="get_quotes"
LINK_PATH="$BIN_DIR/$EXECUTABLE_NAME"

MARKER_START="# --- Quote Generator ---"
MARKER_END="# --- Quote Generator End ---"

printf "Uninstalling quote generator script...\n"

# Clean up startup configuration files across common shells
STARTUP_FILES="$HOME/.bashrc $HOME/.zshrc $HOME/.profile $HOME/.config/fish/config.fish"

for STARTUP_FILE in $STARTUP_FILES; do
    if [ -f "$STARTUP_FILE" ]; then
        printf "%s found, cleaning up...\n" "$STARTUP_FILE"
        TMP_FILE="${STARTUP_FILE}.tmp"
        if grep -q "$MARKER_START" "$STARTUP_FILE" && grep -q "$MARKER_END" "$STARTUP_FILE"; then
            # Safe to use range deletion
            sed "/$MARKER_START/,/$MARKER_END/d" "$STARTUP_FILE" > "$TMP_FILE" && mv "$TMP_FILE" "$STARTUP_FILE"
        else
            # Fallback: remove any single lines matching markers or command
            grep -v -E -e "$MARKER_START" -e "$MARKER_END" -e "^[[:space:]]*get_quotes[[:space:]]*$" \
            "$STARTUP_FILE" > "$TMP_FILE" && mv "$TMP_FILE" "$STARTUP_FILE"
        fi
    fi
done

# Remove the symlink in ~/.local/bin
if [ -L "$LINK_PATH" ] || [ -f "$LINK_PATH" ]; then
    rm -f "$LINK_PATH"
    printf "Removed symlink at %s\n" "$LINK_PATH"
fi

# POSIX-compliant user prompt
printf "Are you sure you want to completely remove the repository at %s? (y/N): " "$REPO_DIR"
read -r REPLY

case "$REPLY" in
    [Yy]*)
        printf "Removing repository directory...\n"
        cd "$HOME"
        rm -rf "$REPO_DIR"
        printf "Uninstallation complete.\n"
        ;;
    *)
        printf "Repository directory retained at %s.\n" "$REPO_DIR"
        ;;
esac
