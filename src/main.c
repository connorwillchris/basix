#include <stdio.h>
#include <stdlib.h>

#include "basix.h"

int main(int argc, char** argv) {
    init_e_reader();
    
    speak_e_reader("Hello, world!");

    deinit_e_reader();
    return 0;
}
