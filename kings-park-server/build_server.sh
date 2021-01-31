#!/bin/sh
config=minecraft_server.json
build_dir=server_build_dir
build_tool_jar=BuildTools.jar

d_url=$(cat $config | jq --raw-output '.download_url' )
command=$(cat $config | jq --raw-output '.command' )

mkdir -p $build_dir
cd $build_dir

curl -o $build_tool_jar $d_url
git config --global --unset core.autocrlf 
$command

