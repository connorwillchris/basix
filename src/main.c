#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "basix.h"
#include "scanner.h"

#define LINE_MAX 1024

char * read_file(const char * path) {
    // open file
    FILE * file = fopen(path, "rb");
    // quick and dirty error check
    if (file == NULL) {
        fprintf(stderr, "Could not open file %s!\n", path);
        exit(74);
    }

    // get the file size
    fseek(file, 0L, SEEK_END);
    size_t filesize = ftell(file);
    rewind(file);

    // return a malloced string, and free it once done!
    char * buffer = (char *)malloc(filesize + 1);
    // quick and dirty error check for memory
    if (buffer == NULL) {
        fprintf(stderr, "Not enough memory to read %s!\n", path);
        exit(74);
    }
    // check the bytes read
    size_t bytesread = fread(buffer, sizeof(char), filesize, file);
    // another quick and dirty error check for reading file
    if (bytesread < filesize) {
        fprintf(stderr, "Could not read file %s!", path);
        exit(74);
    }
    buffer[bytesread] = '\0';

    fclose(file);
    return buffer;
}

static int interpret(char * source) {
    
}

static int run_file(const char * filepath) {
    char * source = read_file(filepath);
    interpret(source);

    free(source);

    return 0;
}

static int repl() {
    char line[1024];
    while (true) {
        if (!fgets(line, LINE_MAX, stdin)) {
            printf("\n");
            break;
        }

        interpret(line);
    }
}

int main(int argc, char ** argv) {
    if (argc == 1) {
        repl();
    }
    else if (argc == 2) {
        run_file(argv[1]);
    }
    else {
        fprintf(stderr, "Usage: basix [file]\n");
        exit(64);
    }

    return 0;
}
