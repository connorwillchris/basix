#ifndef BASIX_H
#define BASIX_H

typedef struct bstate B_State;

B_State * basix_open(void);

void basix_close(B_State *);

#endif
