#ifndef SCANNER_H
#define SCANNER_H

/*
TOKEN TYPE. Includes strings, among other things.
*/
typedef enum {
    T_EOF,

    T_LEFT_PAREN, T_RIGHT_PAREN,
    T_COMMA, T_PERIOD, T_PLUS, T_MINUS,
    T_ASTERISK, T_SLASH, T_BANG, T_EQUALS,

    T_BANG_EQUALS, T_EQUALS_EQUALS,
    T_GREATER, T_GREATER_EQUALS,
    T_LESS, T_LESS_EQUALS,

    // NOTE Should line number be it's own token?
    T_STRING, T_INDENTIFIER, T_NUMBER, T_LINE_NUMBER,

    T_IF, T_ELSE, T_ELSEIF, T_THEN,
    T_WHILE, T_FOR, T_DONE, T_END,
    T_GOTO, T_GOSUB, T_AND, T_OR, T_NOT,
    T_NIL, T_TRUE, T_FALSE, T_IN, T_RETURN,
    T_LET,
} TokenType;

typedef struct {
    TokenType type;
} Token;

#endif
