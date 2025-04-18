#!/usr/bin/sh
zig test --test-filter speak ./src/main.zig -lc -lespeak-ng
