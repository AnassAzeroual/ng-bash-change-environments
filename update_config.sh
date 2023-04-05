#!/bin/bash

echo "Updating config.ts..."

# Read the keys in the config.ts file and create a sed command to set all values to empty string
SED_COMMAND=""
while read -r line; do
  VAR_NAME=$(echo "$line" | grep -Eo '^[^:]+')
  SED_COMMAND+="s/\b$VAR_NAME:\s*[^,}]*[,}]/$VAR_NAME: \"\",/g;"
done < <(grep -Eo '^[^:]+:' src/assets/config.ts)

# Execute the sed command to update the config.ts file
sed -i "$SED_COMMAND" src/assets/config.ts

echo "Empty values updated in config.ts."

# Get the names of all the variables defined in config.ts
VARIABLES=$(grep -Eo '^ *\w+:' src/assets/config.ts | sed 's/://')

# Loop through each variable and create a sed command to update matching keys
SED_COMMAND=""
for VAR_NAME in $VARIABLES; do
  VAR_VALUE=$(echo "${!VAR_NAME}")
  if [ -n "$VAR_VALUE" ]; then
    SED_COMMAND+="s/\b$VAR_NAME:\s*\"[^\"]*\"/$VAR_NAME: \"$VAR_VALUE\"/g;"
    echo "Found environment variable for $VAR_NAME: $VAR_VALUE"
  else
    SED_COMMAND+="s/\b$VAR_NAME:\s*[^,}]*[,}]/$VAR_NAME: \"\",/g;"
  fi
done

# Execute the sed command to update the config.ts file
echo "Running sed command: sed -i \"$SED_COMMAND\" src/assets/config.ts"
sed -i "$SED_COMMAND" src/assets/config.ts

echo "Config.ts updated."
