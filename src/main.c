#include <stdio.h>
#include <stdlib.h>

#include "basix.h"

int main(int argc, char ** argv) {
    B_State * B = basix_open();

    // do stuff with basix here!
    

    basix_close(B);

    return 0;
}
