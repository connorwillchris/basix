# CMAKE we hate you, but you have to be here.
cmake_minimum_required(VERSION 3.10)

# Set the project name
project(basix)

# Add an executable target
add_executable(basix
    src/main.c
    src/basix.c
)
