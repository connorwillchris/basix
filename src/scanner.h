#ifndef SCANNER_H
#define SCANNER_H

typedef enum {
    // end-of-file token
    TOKEN_EOF,

    // single character tokens
    TOKEN_LEFT_PAREN, TOKEN_RIGHT_PAREN, TOKEN_PLUS, TOKEN_MINUS, TOKEN_ASTERISK,
    TOKEN_SLASH, TOKEN_BANG, TOKEN_COMMA,

    // one or two character tokens
} Token;

#endif
