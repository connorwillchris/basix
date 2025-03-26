#include "basix.h"

#include <espeak-ng/espeak_ng.h>
#include <espeak-ng/speak_lib.h>

static espeak_AUDIO_OUTPUT output = AUDIO_OUTPUT_SYNCH_PLAYBACK;
static char* path = NULL;
static void* user_data;
static unsigned int* identifier;
static int buflength = 1024, options = 0;
static unsigned int position = 0, position_type = 0, end_position = 0, flags = espeakCHARS_AUTO;

void init_e_reader() {
    char* voicename = "English";
    espeak_Initialize(output, buflength, path, options);
    espeak_SetVoiceByName(voicename);

    // debug
    printf("Initialized e-reader.\n");
}

void speak_e_reader(const char* string) {
    printf("%s\n", string);
    espeak_Synth(string, buflength, position, position_type, end_position, flags, identifier, user_data);
}

void deinit_e_reader() {
    // debug
    printf("Deinitialized e-reader.\n");
    return;
}
