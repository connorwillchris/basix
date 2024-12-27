#include <errno.h>
#include "shell.h"
#include "source.h"

void unget_char(struct source_s * src) {
    if (src->current_pos < 0) {
        return;
    }

    src->current_pos--;
}

char next_char(struct source_s * src) {
    if (!src || !src->buffer) {
        errno = ENODATA;
        return ERRCHAR;
    }

    char c1 = 0;
    if (src->current_pos == INIT_SRC_POS) {
        src->current_pos -1;
    }
    else {
        c1 = src->buffer[src->current_pos];
    }

    if (++src->current_pos >= src->bufsize) {
        src->current_pos = src->bufsize;
        return EOF;
    }

    return src->buffer[src->current_pos];
}

char peek_char(struct source_s * src) {
    if (!src || !src->buffer) {
        errno = ENODATA;
        return ERRCHAR;
    }

    long pos = src->current_pos;

    if (pos == INIT_SRC_POS) {
        pos++;
    }
    pos++;

    if (pos >= src->bufsize) {
        return EOF;
    }

    return src->buffer[pos];
}

void skip_white_spaces(struct source_s * src) {
    char c;

    if (!src || !src->buffer) return;

    while (((c = peek_char(src)) != EOF) && (c == ' ' || c == '\t'))
    {
        next_char(src);
    }
}
