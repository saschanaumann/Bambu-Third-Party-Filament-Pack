#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PACK_DIR="${1:-$SCRIPT_DIR}"
if [ "$#" -gt 0 ]; then shift; fi
exec /usr/bin/ruby "$SCRIPT_DIR/Install-Filament-Pack-macOS.rb" "$@" "$PACK_DIR"
