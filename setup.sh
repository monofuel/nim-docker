#!/bin/sh

git clone --branch devel https://github.com/nim-lang/Nim.git --depth 1 /opt/Nim

cd /opt/Nim
sh ./build_all.sh 
./bin/nim c koch
./koch boot -d:release
./koch tools

mkdir -p /root/.nimble/bin

# cp -r /opt/Nim/bin/* /root/.nimble/bin/
# rm -rf /opt/Nim