#!/bin/sh
config=modlist.json
download_dir=mod_downloads

mkdir -p $download_dir
echo "Unable to use curl to download due to cloudflare protection. Use a browser and download the following files"
echo "  Please put the files in the directory $download_dir since i'll push it to the server for you"


echo ""
cat $config | jq --raw-output '.[] | .url' 

