#!/bin/bash

CONFIG_FILE="src/assets/config.ts"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]
then
  echo "Config file not found: $CONFIG_FILE"
  exit 1
fi

# Read the existing config file and extract the keys and values
while IFS= read -r line
do
  if [[ $line =~ ^[[:space:]]*([a-zA-Z_]+):[[:space:]]+'(.*)',?$ ]]
  then
    keys+=(${BASH_REMATCH[1]})
    values+=(${BASH_REMATCH[2]})
  fi
done < "$CONFIG_FILE"

# Loop through the keys and check if there's a matching environment variable
for (( i=0; i<${#keys[@]}; i++ ))
do
  key=${keys[$i]}
  value=${values[$i]}
  echo "Updating config key $key with value $value"
  # Get the environment variable value if it exists
  env_var=$(printenv $key)

  # If the environment variable exists, update the config file
  if [ ! -z "$env_var" ]
  then
    echo "Updating config key $key with value $env_var"
  
    # Update the value for the key in the config file
    sed -i "s/$key: '$value'/$key: '$env_var'/" "$CONFIG_FILE"
  fi
done
