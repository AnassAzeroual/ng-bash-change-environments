#!/bin/bash

CONFIG_FILE="src/assets/config.ts"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]
then
  echo "Config file not found: $CONFIG_FILE"
  exit 1
fi

# Read the existing config file and extract the keys
keys=$(grep -oP '(?<=: )'\''[a-zA-Z_]+'\''(?=,)' "$CONFIG_FILE")

# Loop through the keys and check if there's a matching environment variable
for key in $keys
do
  # Get the environment variable value if it exists
  env_var=$(printenv $key)

  # If the environment variable exists, update the config file
  if [ ! -z "$env_var" ]
  then
    # Update the value for the key in the config file
    sed -i "s/$key: '\''[^'\'']*'\''/$key: '\''$env_var'\''/" "$CONFIG_FILE"
  fi
done
