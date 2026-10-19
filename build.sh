#!/usr/bin/env bash
# Renders RAW_BASE / DISCORD_WEBHOOK placeholders in Payloads/**/*.txt using config.env,
# writing the result to dist/ (mirrors Payloads/ layout) so templates never carry secrets.
# shortcut: only substitutes RAW_BASE/DISCORD_WEBHOOK, nothing else is parameterized yet;
# add more vars to config.env.example + the VARS list below if a payload needs one.
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f config.env ]; then
  echo "Missing config.env - copy config.env.example to config.env and fill in your values." >&2
  exit 1
fi
set -a; source config.env; set +a

VARS='$RAW_BASE $DISCORD_WEBHOOK'

rm -rf dist
find Payloads -type f -name '*.txt' -print0 | while IFS= read -r -d '' f; do
  out="dist/${f#Payloads/}"
  mkdir -p "$(dirname "$out")"
  envsubst "$VARS" < "$f" > "$out"
done

echo "Built payloads in dist/ - copy the .txt you need onto the Flipper's badusb folder."
