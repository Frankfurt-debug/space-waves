#!/bin/bash
# Double-click (or run: ./start.sh) to play Space Waves locally.
cd "$(dirname "$0")"

PORT=8080
URL="http://localhost:$PORT/index.html"

if command -v python3 >/dev/null 2>&1; then
  SERVER="python3 -m http.server $PORT"
elif command -v python >/dev/null 2>&1; then
  SERVER="python -m http.server $PORT"
elif command -v npx >/dev/null 2>&1; then
  SERVER="npx --yes serve -l $PORT ."
else
  echo "Could not find python3, python, or npx on this machine."
  echo "Install Python (https://python.org) and run this script again."
  read -p "Press Enter to exit..."
  exit 1
fi

$SERVER &
SERVER_PID=$!
trap "kill $SERVER_PID 2>/dev/null" EXIT

sleep 1

if command -v open >/dev/null 2>&1; then
  open "$URL"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$URL"
else
  echo "Open this URL in your browser: $URL"
fi

echo "Server running at $URL"
echo "Close this window (or press Ctrl+C) to stop the game server."
wait $SERVER_PID
