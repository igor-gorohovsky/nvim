#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-$HOME/.config/nvim/init.lua}"

if [[ -z "${ZELLIJ_SESSION_NAME:-}" ]]; then
  echo "ZELLIJ_SESSION_NAME not set. Run from inside a zellij session." >&2
  exit 1
fi

SOCK="/tmp/nvim-claude-$ZELLIJ_SESSION_NAME.sock"
if [[ ! -S "$SOCK" ]]; then
  echo "Socket $SOCK not found." >&2
  echo "Is nvim running with the claude_review plugin loaded in this zellij session?" >&2
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  echo "File not found: $FILE" >&2
  exit 1
fi

PENDING=$(mktemp /tmp/claude-pending-XXXXXX)
FIFO_DIR=$(mktemp -d /tmp/claude-fifo-XXXXXX)
FIFO="$FIFO_DIR/fifo"
NOTES=$(mktemp /tmp/claude-notes-XXXXXX)

cleanup() {
  rm -rf "$PENDING" "$FIFO_DIR" "$NOTES"
}
trap cleanup EXIT

{
  cat "$FILE"
  echo ""
  echo "-- TEST PENDING CHANGE injected by test-claude-review.sh"
} > "$PENDING"

mkfifo "$FIFO"

cat <<EOF
Test setup:
  file    $FILE
  pending $PENDING
  fifo    $FIFO
  notes   $NOTES

Keymaps in the diff buffer:
  <Leader>ca  approve
  <Leader>cd  decline (quick)
  <Leader>cD  decline with comment
  <Leader>cn  approve + note
EOF

LUA="require('claude_review').start({"
LUA+="file=[[${FILE}]],"
LUA+="pending=[[${PENDING}]],"
LUA+="fifo=[[${FIFO}]],"
LUA+="notes_file=[[${NOTES}]]"
LUA+="})"

nvim --server "$SOCK" --remote-send "<C-\\><C-n>:lua ${LUA}<CR>"

zellij action move-focus left >/dev/null 2>&1 || true

echo
echo "Waiting for decision..."
DECISION=$(cat "$FIFO")
echo "Decision: $DECISION"

if [[ -s "$NOTES" ]]; then
  echo
  echo "Notes captured:"
  cat "$NOTES"
fi
