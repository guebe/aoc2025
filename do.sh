#!/bin/sh
make SCHEME=csi FLAGS=-s
make SCHEME=guile FLAGS=-q
make SCHEME=petite FLAGS=--script
make SCHEME=scm754
