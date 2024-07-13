#!/bin/bash

set -e

if [ ! -s "/data/all_cities_unique.json" ]; then
  /usr/local/bin/download_states.sh

  /usr/local/bin/filter_cities.sh

  /usr/local/bin/remove_duplicate_cities.sh
else
  echo "all_cities_unique.json already exists and is not empty. Skipping data processing."
fi

echo "Data processing completed."

echo "MongoDB is ready, proceeding with data import..."

mongoimport --host "city-coordinates-db" --username user --password user --authenticationDatabase admin \
  --db us --collection cities --type json --file /data/all_cities_unique.json --jsonArray

echo "Data import completed."
