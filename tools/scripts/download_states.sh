#!/bin/bash

base_url="http://download.geofabrik.de/north-america/us"

states_file="/config/states.json"

output_dir="/data/states"

mkdir -p "$output_dir"

process_state() {
  local state=$1
  local url="$base_url/$(echo "$state" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')-latest.osm.pbf"
  local pbf_file="$output_dir/$state.osm.pbf"

  if [ ! -f "$pbf_file" ]; then
    echo "Downloading $state OSM PBF from $url..."
    wget -O "$pbf_file" "$url"
  else
    echo "$state OSM PBF already exists. Skipping download."
  fi
}

jq -r '.states[]' "$states_file" | while read -r state; do
  process_state "$state"
done

echo "All states processed."
