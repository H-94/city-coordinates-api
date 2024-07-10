#!/bin/bash

input_file="/data/filtered-cities/all_cities.json"
tmp_file="/data/filtered-cities/all_cities_tmp.json"
output_file="/data/all_cities_unique.json"

# Ensure the input JSON is a valid array
jq -s 'flatten' "$input_file" > "$tmp_file"

# Remove duplicates
jq 'unique_by(.properties.name + "," + .properties.state)' "$tmp_file" > "$output_file"

# Clean up temporary file
rm "$tmp_file"

echo "Duplicates removed. Unique cities saved to $output_file."