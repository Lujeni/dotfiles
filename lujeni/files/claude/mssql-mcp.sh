#!/bin/bash
# Wrapper around Data API builder (dab) MCP server, one process per database.
#
# Usage: mssql-mcp.sh [DATABASE] [SERVER]
#   DATABASE  default: contents of ~/.config/dab/current_db
#             (switch DB: echo OTHER_DB > ~/.config/dab/current_db, then /mcp reconnect)
#   SERVER    default: $MSSQL_SERVER from ~/.config/dab/env
#             *.database.windows.net -> SQL auth (MSSQL_LOGIN / MSSQL_PASSWORD)
#             anything else          -> Kerberos (kinit first)
#
# ~/.config/dab/env (not managed, chmod 600):
#   export MSSQL_SERVER=...
#   export MSSQL_LOGIN=...
#   export MSSQL_PASSWORD=...
set -e
CONF="$HOME/.config/dab"
[ -f "$CONF/env" ] && source "$CONF/env"
DB="${1:-$(cat "$CONF/current_db" 2>/dev/null)}"
SERVER="${2:-$MSSQL_SERVER}"
[ -n "$DB" ] && [ -n "$SERVER" ] || { echo "mssql-mcp: DATABASE and SERVER required (see $CONF/env)" >&2; exit 1; }
COMMON="Server=tcp:${SERVER},1433;Database=${DB};Encrypt=True;TrustServerCertificate=True;Connect Timeout=30;"
case "$SERVER" in
  *database.windows.net) AUTH="User ID=${MSSQL_LOGIN};Password=${MSSQL_PASSWORD};" ;;
  *) AUTH="Integrated Security=true;MultiSubnetFailover=True;" ;;
esac
export MSSQL_CONNECTION_STRING="${COMMON}${AUTH}"
export ASPNETCORE_URLS="http://127.0.0.1:0"
exec "$HOME/.dotnet/tools/dab" start --mcp-stdio role:anonymous --LogLevel Error --config "$CONF/dab-config.json"
