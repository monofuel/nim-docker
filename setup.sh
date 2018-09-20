#!/bin/bash

sh build_all.sh 
./bin/nim c koch
./koch boot -d:release
./koch tools

# TODO clean up sources