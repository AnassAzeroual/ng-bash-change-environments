#!/bin/bash

echo "Updating config.ts..."

# Read the environment variables and create a sed command to update matching keys
SED_COMMAND=""
while read -r line; do
  VAR_NAME=$(echo "$line" | cut -d= -f1)
  VAR_VALUE=$(echo "$line" | cut -d= -f2-)
  SED_COMMAND+="s/\b$VAR_NAME:\s*\"[^\"]*\"/$VAR_NAME: \"$VAR_VALUE\"/g;"
done < <(env | grep -E "^Angular_v=|^Ionic_v=")

# Execute the sed command to update the config.ts file
sed -i "$SED_COMMAND" src/assets/config.ts

echo "Config.ts updated."
