#!/bin/sh

# Find path to repo
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$HOME/.local/bin"
EXECUTABLE_NAME="get_quotes"
LINK_PATH="$BIN_DIR/$EXECUTABLE_NAME"

printf "Setting up startup script for terminal quote generator from: %s\n" "$REPO_DIR"

# Ensure ~/.local/bin exists
mkdir -p "$BIN_DIR"

# Prepend shebang to get_quotes.py if not already present
if ! head -n 1 "$REPO_DIR/get_quotes.py" | grep -q "^#!/usr/bin/env python3"; then
    printf "Adding Python shebang to get_quotes.py...\n"
    TMP_FILE="$REPO_DIR/get_quotes.py.tmp"
    { printf '#!/usr/bin/env python3\n'; cat "$REPO_DIR/get_quotes.py"; } > "$TMP_FILE" \
        && mv "$TMP_FILE" "$REPO_DIR/get_quotes.py"
fi

# Ensure generator can be executed
chmod +x "$REPO_DIR/get_quotes.py"

# Create symlink in ~/.local/bin
ln -sf "$REPO_DIR/get_quotes.py" "$LINK_PATH"
printf "Created symlink to quote provider at %s\n" "$LINK_PATH"

# Detect current shell and assign configuration file
USER_SHELL="$(basename "${SHELL:-bash}")"
case "$USER_SHELL" in
    zsh)
        STARTUP_FILE="$HOME/.zshrc"
        ;;
    bash)
        STARTUP_FILE="$HOME/.bashrc"
        ;;
    fish)
        STARTUP_FILE="$HOME/.config/fish/config.fish"
        ;;
    *)
        STARTUP_FILE="$HOME/.profile"
        ;;
esac

COMMAND_LINE="get_quotes"

printf "Detected shell: %s with startup file %s\n" "$USER_SHELL" "$STARTUP_FILE"

# Ensure startup file exists
touch "$STARTUP_FILE"

MARKER_START="# --- Quote Generator ---"
MARKER_END="# -------------------------------"

if grep -q "$COMMAND_LINE" "$STARTUP_FILE"; then
    printf "Quote generator command already present in startup file.\n"
else
    printf "Appending startup command to %s...\n" "$STARTUP_FILE"
    {
        printf "\n"
        printf "%s\n" "$MARKER_START"
        printf "%s\n" "$COMMAND_LINE"
        printf "%s\n" "$MARKER_END"
    } >> "$STARTUP_FILE"
    printf "Successfully updated %s.\n" "$STARTUP_FILE"
fi

printf "Installation complete! Make sure %s is in your \$PATH.\n" "$BIN_DIR"
