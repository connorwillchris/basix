#ifndef BASIX_H
#define BASIX_H

/*
The pointer for interfacing with BASIX.
*/
typedef struct bstate B_State;

/*
Open a `BASIX` state.

`TODO` Later on, turn this function into a multi-heap allocatable function, that can take any malloc or otherwise function.
*/
B_State * basix_open(void);

/*
Close the `BASIX` state.

Will free all the memory associated with it and clean up the VM.
*/
void basix_close(B_State * b_state);

/*
REPL interface for the shell as well as starting up BASIX with a traditional windows command line application.
*/
int basix_repl(B_State * b_state);

#endif
