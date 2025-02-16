#include <espeak-ng/speak_lib.h>
#include <string.h>

#include "basix.h"

static espeak_AUDIO_OUTPUT output = AUDIO_OUTPUT_SYNCH_PLAYBACK;
static char * path = NULL;
static void * user_data;
static unsigned int * identifier;
static int buflength = OUTPUT_MAX_LEN,
    options = 0,
    position = 0,
    position_type = 0,
    end_position = 0,
    flags = espeakCHARS_AUTO;
static espeak_VOICE voice;

int init_reader() {
    int result = espeak_Initialize(
        output, buflength, path, options
    );
    espeak_SetVoiceByName("English");

    return 0;
}

void deinit_reader() {
    // deinit the e-reader
}    
    
int reader_synth(char *buffer) {
    espeak_Synth(
        buffer,
        buflength,
        position,
        position_type,
        end_position,
        flags,
        identifier,
        user_data
    );

    return 0;
}
