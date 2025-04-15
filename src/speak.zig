const std = @import("std");
const c = @cImport(
    @cInclude("espeak/speak_lib.h"),
);

const output = c.AUDIO_OUTPUT_SYNCH_PLAYBACK;
var path = c.NULL;
var user_data = c.NULL;
var identifier: *c_int = c.NULL;

//var text: [1024]u8 = undefined;

pub const Speaker = struct {
    buflength: c_int,

    pub fn new(
        buflength: c_int,
    ) !Speaker {
        const voicename = "English";
        //const buflength = 1024;
        const options = 0;

        c.espeak_Initialize(
            output,
            buflength,
            path,
            options,
        );

        c.espeak_SetVoiceByName(voicename);
        return .{
            .buflength = buflength,
        };
    }

    pub fn say(self: Speaker, text: []const u8) !void {
        const position = 0;
        const position_type = 0;
        const end_position = 0;
        const flags = c.espeakCHARS_AUTO;

        c.espeak_Synth(
            text,
            self.buflength,
            position,
            position_type,
            end_position,
            flags,
            identifier,
            user_data,
        );
    }

    pub fn free() !void {
        // do nothing for now...
        return;
    }
};
