#!/bin/bash
# Sync claude user-scope MCP servers from ~/.config/dab/servers.conf (unmanaged).
#
# servers.conf format, one server per line:
#   <mcp-name> <database|-> [server]
#   '-' as database = read ~/.config/dab/current_db at start (switchable without re-sync)
#   server omitted  = $MSSQL_SERVER from ~/.config/dab/env
# Every sql-* MCP server not listed in servers.conf is removed.
set -e
CONF="$HOME/.config/dab"
WRAPPER="$CONF/mssql-mcp.sh"
[ -f "$CONF/servers.conf" ] || { echo "mssql-mcp-sync: $CONF/servers.conf missing" >&2; exit 1; }

existing=$(claude mcp list 2>/dev/null | grep -oE '^sql-[^:]+' || true)
wanted=()
changed=0

while read -r name db server; do
  wanted+=("$name")
  desired="$WRAPPER $db${server:+ $server}"
  current=$(claude mcp get "$name" 2>/dev/null | awk '/^  Command:/{c=$2} /^  Args:/{sub(/^  Args: /,""); a=$0} END{print c (a?" " a:"")}')
  [ "$current" = "$desired" ] && continue
  grep -qx "$name" <<<"$existing" && claude mcp remove --scope user "$name" >/dev/null
  # shellcheck disable=SC2086
  claude mcp add --scope user "$name" -- "$WRAPPER" "$db" $server >/dev/null
  echo "registered $name"; changed=1
done < <(grep -Ev '^\s*(#|$)' "$CONF/servers.conf")

for name in $existing; do
  printf '%s\n' "${wanted[@]}" | grep -qx "$name" && continue
  claude mcp remove --scope user "$name" >/dev/null
  echo "removed $name"; changed=1
done

[ "$changed" = 1 ] && echo "CHANGED" || echo "up to date"
