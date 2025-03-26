#ifndef SCANNER_H
#define SCANNER_H

typedef enum {
    // end-of-file token
    TOKEN_EOF,

    // single character tokens
    TOKEN_LEFT_PAREN, TOKEN_RIGHT_PAREN, TOKEN_PLUS,
    TOKEN_MINUS, TOKEN_ASTERISK, TOKEN_SLASH,
    TOKEN_BANG, TOKEN_COMMA, TOKEN_SEMICOLON,
    TOKEN_BACKSLASH,

    // one or two character tokens
    // keywords
    /*
        AND, OR, NOT
        WHILE, DONE
        GOTO, GOSUB, RETURN
        IF, THEN, ELSE, ELSEIF

        --NON KEYWORDS--
        INPUT, SAY/PRINT, PAUSE
    */

} Token;

#endif