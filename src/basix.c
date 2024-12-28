#include <stdio.h>
#include <stdlib.h>

#include "basix.h"

typedef struct bstate {
    int stuff_here;

    // stack stuff may be here too!
};

typedef struct bstate B_State;

B_State * basix_open() {
    B_State * B = (B_State* )malloc(1024);          // malloc some bullcrap for the moment, TODO Change this later!
    return B;
}

void basix_close(B_State * B) {
    free(B);
    return;
}

int basix_repl(B_State * B) {
    return 0; // do nothing
}
