const std = @import("std");
const e_reader = @import("speak.zig");
const Speaker = e_reader.Speaker;
const Scanner = @import("scanner.zig").Scanner;
const parser = @import("parser.zig");

const program =
    \\10 ELSE ELSEIF AND "HELLO WORLD
    \\WHAT IS YOUR NAME?";
    \\20 GOTO 10;
;

pub fn main() !void {
    // scanner here
    const allocator = std.heap.page_allocator;

    var scanner = Scanner.new(allocator, program);
    const tokens = try scanner.scanTokens();

    for (tokens.items) |token| {
        std.debug.print("token_type: {?} - literal: {s}\n", .{
            token.token_type,
            token.lexeme,
        });
    }
}

fn doShell() !u8 {
    const bufsize = 1024;
    const speaker = try Speaker.new(bufsize);
    defer speaker.free();

    try speaker.say("Hello, world!");
}

test "speak" {
    const bufsize: usize = 1024;
    const speaker = try Speaker.new(bufsize);
    defer speaker.free();

    try speaker.say("Hello, world!");
}
