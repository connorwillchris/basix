#!/usr/bin/sh

# This is just for testing purposes, and is not
# meant to be used in the final build...!

mkdir -p build

gcc -o build/basix \
    src/main.c \
    src/basix.c \
    src/scanner.c \
    src/chunk.c \
    -lespeak-ng
