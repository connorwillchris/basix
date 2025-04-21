const std = @import("std");
const speaker = @import("speaker.zig");
const scanner = @import("scanner.zig");

pub fn main() !void {
    const program =
        \\10 PRINT "HELLO WORLD";
        \\20 GOTO 10;
    ;
    //const S = scanner.Scanner.new(program);
    var s = scanner.Scanner.new(
        std.heap.page_allocator,
        program,
    );
    const tokens = try s.scanTokens();

    //s.tokens
    for (tokens.items) |t| {
        std.debug.print("{d}", .{t.line});
    }
}

test "speak" {
    const bufsize: usize = 1024;
    const s = try speaker.Speaker.new(bufsize);
    defer s.free();

    try s.say("Hello, world!");
}
