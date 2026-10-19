# FlipperZero-BadUSB
Collection of self-made BadUSB/RubberDucky scripts

## Usage
Some payloads reference a webhook URL or this repo's raw URL as `$DISCORD_WEBHOOK`/`$RAW_BASE` placeholders instead of hardcoding them. To fill those in:

1. `cp config.env.example config.env` and set your values.
2. `./build.sh` — renders every `Payloads/**/*.txt` into `dist/` with the placeholders substituted.
3. Copy the payload you need from `dist/` to the Flipper's `badusb` folder.

Payloads with no placeholders work the same either way; `config.env` and `dist/` are gitignored.
