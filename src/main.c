#include <stdio.h>
#include <stdlib.h>

#include "basix.h"

int main(int argc, char ** argv) {
    B_State * B = basix_open();
    /*
    Do stuff with BASIX HERE!
    Will only include REPL for now...
    */
    basix_repl(B);

    basix_close(B);
    return 0;
}
