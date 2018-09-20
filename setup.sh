#!/bin/sh

git clone https://github.com/nim-lang/Nim.git --depth 1 /opt/Nim

cd /opt/Nim
sh ./build_all.sh 
./bin/nim c koch
./koch boot -d:release
./koch tools

# TODO clean up sources