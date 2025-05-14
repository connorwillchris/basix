const std = @import("std");
const e_reader = @import("speak.zig");
const Scanner = @import("scanner.zig").Scanner;

const program =
    \\10 PRINT "HELLO WORLD \
    \\WHAT IS YOUR NAME?";
    \\20 GOTO 10;
;

pub fn main() !void {
    // scanner here
    const allocator = std.heap.page_allocator;

    var scanner = Scanner.new(allocator, program);
    const tokens = try scanner.scanTokens();

    for (tokens.items) |token| {
        std.debug.print("token_type: {?} - lexeme: {s}\n", .{
            token.token_type,
            if (std.mem.eql(
                u8,
                token.lexeme,
                "\n",
            )) "NEWLINE" else token.lexeme,
        });
    }
}

fn doShell() !u8 {
    const bufsize = 1024;
    const speaker = try e_reader.Speaker.new(bufsize);
    defer speaker.free();

    try speaker.say("Hello, world!");
}

test "speak" {
    const bufsize: usize = 1024;
    const speaker = try e_reader.Speaker.new(bufsize);
    defer speaker.free();

    try speaker.say("Hello, world!");
}
