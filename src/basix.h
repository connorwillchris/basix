#ifndef BASIX_H
#define BASIX_H

#define OUTPUT_MAX_LEN 1024

/*
 * Initialize an e-reader for the
 * shell.
 */
int reader_init();

/*
 * Close the e-reader once we are done with
 * the project.
 */
void reader_close();

/*
 * Speak or synth some buffer.
 */
int reader_synth(char * buffer);

#endif
