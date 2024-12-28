#include <stdio.h>
#include <stdlib.h>

#include "basix.h"

typedef struct bstate {

};

typedef struct bstate B_State;

/*
Hidden from the average user. You interface with BASIX using the B_State pointer. Developers will use this in the implementation.
*/

B_State * basix_open() {
    B_State * B = (B_State* )malloc(1024);          // malloc some bullcrap for the moment
    return B;
}

void basix_close(B_State * B) {
    free(B);
    return;
}
