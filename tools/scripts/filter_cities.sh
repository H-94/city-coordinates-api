#!/bin/bash

states_dir="/data/states"

output_dir="/data/filtered-cities"

mkdir -p "$output_dir"

echo '[]' > "$output_dir/all_cities.json"

process_state() {
  local state=$1
  local state_pbf="$states_dir/$state.osm.pbf"
  local filtered_pbf="$output_dir/$state-filtered.osm.pbf"
  local geojson_file="$output_dir/$state-cities.geojson"

  osmium tags-filter "$state_pbf" n/place=city n/place=town n/place=village n/place=hamlet -o "$filtered_pbf"

  ogr2ogr -f "GeoJSON" --config OSM_CONFIG_FILE /config/osmconf.ini "$geojson_file" "$filtered_pbf" -skipfailures
    
  if [ -s "$geojson_file" ]; then
    jq --arg state "$state" -c '
        .features[] | 
        {type: .type, properties: (.properties + {state: $state}), geometry: .geometry}
    ' "$geojson_file" >> "$output_dir/all_cities.json.tmp"
  else
    echo "Warning: $geojson_file is empty or does not exist."
  fi
}

for pbf_file in "$states_dir"/*.osm.pbf; do
  state=$(basename "$pbf_file" .osm.pbf)
  state=$(echo "$state" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  process_state "$state"
done

jq -s '.' "$output_dir/all_cities.json.tmp" > "$output_dir/all_cities.json"
rm "$output_dir/all_cities.json.tmp"

echo "All cities processed and combined into $output_dir/all_cities.json."
