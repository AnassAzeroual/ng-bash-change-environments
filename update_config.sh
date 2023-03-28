#!/bin/bash

# Check if config file exists, and create one if not
if [ ! -f config.json ]
then
  echo "{}" > config.json
fi

# Read the existing config file and extract the keys
keys=$(jq 'keys[]' config.json)

# Loop through the keys and check if there's a matching environment variable
for key in $keys
do
  # Get the environment variable value if it exists
  env_var=$(printenv $key)

  # If the environment variable exists, update the config file
  if [ ! -z "$env_var" ]
  then
    # Update the value for the key in the config file
    jq ".$key=\"$env_var\"" config.json > temp.json && mv temp.json config.json
  fi
done
