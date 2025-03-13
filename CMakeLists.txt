cmake_minimum_required(VERSION 3.0)
project(basix)

add_executable(basix src/main.c src/basix.c src/scanner.c)
target_link_libraries(basix PUBLIC espeak-ng)
