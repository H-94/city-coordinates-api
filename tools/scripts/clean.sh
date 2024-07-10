#!/bin/bash

filtered_cities_dir="/data/filtered-cities"
unique_cities_file="/data/all_cities_unique.json"

# Check if the filtered cities directory exists and delete it
if [ -d "$filtered_cities_dir" ]; then
  echo "Deleting $filtered_cities_dir..."
  rm -rf "$filtered_cities_dir"
  echo "$filtered_cities_dir deleted."
else
  echo "$filtered_cities_dir does not exist."
fi

# Check if the unique cities file exists and delete it
if [ -f "$unique_cities_file" ]; then
  echo "Deleting $unique_cities_file..."
  rm "$unique_cities_file"
  echo "$unique_cities_file deleted."
else
  echo "$unique_cities_file does not exist."
fi

echo "Cleanup completed."
