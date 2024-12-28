#ifndef SCANNER_H
#define SCANNER_H

/*
TOKEN TYPE. Includes strings, among other things.
*/
typedef enum {
    T_EOF,              // End of file token!

    T_SEMICOLON,        // one or two character tokens
    T_SLASH,            // ...division or a slash
    
} TokenType;

typedef struct {
    TokenType type;
} Token;

#endif
