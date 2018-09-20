#!/bin/sh

git clone https://github.com/nim-lang/Nim.git --depth 1 /opt/Nim

sh /opt/Nim/build_all.sh 
/opt/Nim/bin/nim c koch
/opt/Nim/koch boot -d:release
/opt/Nim/koch tools

# TODO clean up sources