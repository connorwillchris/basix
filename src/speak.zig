/// By default, this basix interpreter uses the
/// espeak-ng library for e-reader.
const std = @import("std");

// c-import statement for any e-reader system. Should interface the same for all
// e-readers using a similar interface.
const c = @cImport({
    @cInclude("espeak-ng/speak_lib.h");
});

const output = c.AUDIO_OUTPUT_SYNCH_PLAYBACK;
var path: *u8 = undefined;
var user_data = c.NULL;
var identifier: [*]c_uint = undefined;

pub const Speaker = struct {
    buflength: c_int,

    pub fn new(
        buflength: c_int,
    ) !Speaker {
        const voicename = "English";
        const options = 0;

        _ = c.espeak_Initialize(
            output,
            buflength,
            path,
            options,
        );

        _ = c.espeak_SetVoiceByName(voicename);

        return .{
            .buflength = buflength,
        };
    }

    pub fn say(self: Speaker, text: ?*const anyopaque) !void {
        const position = 0;
        const position_type = 0;
        const end_position = 0;
        const flags = c.espeakCHARS_AUTO;

        _ = c.espeak_Synth(
            text,
            @intCast(self.buflength),
            position,
            position_type,
            end_position,
            flags,
            identifier,
            user_data,
        );
    }

    pub fn free(self: Speaker) void {
        // do nothing for now...
        _ = self;
        return;
    }
};
