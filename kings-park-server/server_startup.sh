#!/bin/sh

MEM_SIZE=2G
JAR_FILE="spigot.jar"
MEM_ARGS=="-Xms${MEM_SIZE} -Xmx${MEM_SIZE} -XX:+UseG1GC"
ARGS="nogui"

if [ -f $JAR_FILE ] ; then
   java $MEM_ARGS -jar $JAR_FILE $ARGS
else
   echo "ERROR: Jar file $JAR_FILE does not exist. exiting."
   exit 1
fi

