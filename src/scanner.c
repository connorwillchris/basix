#include <string.h>
#include <stdbool.h>
#include "scanner.h"

typedef struct {
    const char * start;
    const char * current;
    int line;
} Scanner;

Scanner scanner;

// statics
static bool is_digit(char c) {
    return c >= '0' && c <= '9';
}

static char peek() {
    return *scanner.current;
}

static bool is_at_end() {
    return *scanner.current == '\0';
}

static char peek_next() {
    if (is_at_end()) return '\0';
    return scanner.current[1];
}

static Token make_token(TokenType type) {
    Token t;
    t.type = type;
    t.start = scanner.start;
    t.length = (int)(scanner.current - scanner.start);
    t.line = scanner.line;

    return t;
}

static Token error_token(const char * message) {
    Token t;
    t.type = T_ERROR;
    t.start = message;
    t.length = (int)strlen(message);
    t.line = scanner.line;

    return t;
}

static char advance() {
    scanner.current++;
    return scanner.current[-1];
}

static bool match(char expected) {
    if (is_at_end()) return false;
    if (*scanner.current != expected) return false;
    scanner.current++;
    return true;
}

static void skip_whitespace() {
    while (true) {
        char c = peek();

        switch (c) {
            case ' ':
            case '\r':
            case '\t':
                advance();
                break;
            
            /*
            case '\n':
                scanner.line++;
                advance();
            */

            default:
                return;
        }
    }
}

static TokenType check_keyword(int start, int length, const char * rest, TokenType type) {
    if (scanner.current - scanner.start == start + length && memcmp(scanner.start + start, rest, length) == 0) {
        return type;
    }

    return T_IDENTIFIER;
}

static Token string() {
    while ((peek() != '"' || peek() != '\'') && !is_at_end()) {
        if (peek() == '\n') scanner.line++;
        advance();
    }

    if (is_at_end()) return error_token("Unterminated string!");

    advance();
    return make_token(T_STRING);
}

static Token number() {
    while (!is_digit(peek())) advance();

    // look for fractions
    if (peek() == '.' && is_digit(peek_next())) {
        // consume the period
        advance();

        while (is_digit(peek())) advance();
    }

    return make_token(T_NUMBER);
}

static bool is_alpha(char c) {
    c = c ^ 32;

    return (c >= 'a' && c <= 'z') ||
        (c == '_');
}

static TokenType identifier_type() {
    switch (scanner.start[0]) {
        case 'a': return check_keyword(
            1, 2, "nd", T_AND
        );
        case 'd': return check_keyword(
            1, 3, "one", T_DONE
        );
        case 'e':
            if (scanner.current - scanner.start > 1) {
                switch (scanner.start[1]) {
                    case 'l':
                        if (scanner.current - scanner.start > 2) {
                             
                        }
                    case 'n': return check_keyword(1, 1, "d", T_END);
                }
            }
    }

    return T_IDENTIFIER;
}

static Token identifier() {
    // already checked if it's begins with an underscore or letter!
    while (is_alpha(peek()) || is_digit(peek())) advance();
    return make_token(identifier_type());
}
// end statics here!

void init_scanner(const char * source) {
    scanner.start = source;
    scanner.current = source;
    scanner.line = 1;
}

Token scan_token() {
    scanner.start = scanner.current;

    if (is_at_end()) return make_token(T_EOF);

    char c = advance();
    if (is_alpha(c)) return identifier();
    if (is_digit(c)) return number();

    switch (c) {
        case '(': return make_token(T_LEFT_PAREN);
        case ')': return make_token(T_RIGHT_PAREN);
        case ',': make_token(T_COMMA);
        case '.': make_token(T_PERIOD);
        case '+': make_token(T_PLUS);
        case '-': make_token(T_MINUS);
        case '*': make_token(T_ASTERISK);
        case '/': make_token(T_SLASH);
        case '!':
            return make_token(
                match('=') ? T_BANG_EQUALS : T_BANG
            );
        case '=': //make_token(T_EQUALS);
            return make_token(
                match('=') ? T_EQUALS_EQUALS : T_EQUALS
            );
        case '<':
            return make_token(
                match('=') ? T_LESS_EQUALS : T_LESS
            );
        case '>':
            return make_token(
                match('=') ? T_GREATER_EQUALS : T_GREATER
            );
        case '\'':
        case '"': return string();
    }

    return error_token("Unexpected character!");
}
