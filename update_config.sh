#!/bin/bash

echo "Updating config.ts..."

# Get the names of all the variables defined in config.ts
VARIABLES=$(grep -Eo '^ *\w+:' src/assets/config.ts | sed 's/://')

# Loop through each variable and create a sed command to update matching keys
SED_COMMAND=""
for VAR_NAME in $VARIABLES; do
  VAR_VALUE=$(echo "${!VAR_NAME}")
  if [ -n "$VAR_VALUE" ]; then
    SED_COMMAND+="s/\b$VAR_NAME:\s*\"[^\"]*\"/$VAR_NAME: \"$VAR_VALUE\"/g;"
    echo "Found environment variable for $VAR_NAME: $VAR_VALUE"
  fi
done

# Execute the sed command to update the config.ts file
echo "Running sed command: sed -i \"$SED_COMMAND\" src/assets/config.ts"
sed -i "$SED_COMMAND" src/assets/config.ts

echo "Config.ts updated."
