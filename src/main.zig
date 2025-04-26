const std = @import("std");
const speak = @import("speak.zig");
const scanner = @import("scanner.zig");
const chunk = @import("chunk.zig");

const program =
    \\10 PRINT "HELLO WORLD";
    \\20 GOTO 10;
;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const c = chunk.Chunk.new(allocator);

    c.writeChunk(chunk.Opcode.Return);
}

fn doShell() !void {
    const bufsize: usize = 1024;
    const speaker = try speak.Speaker.new(bufsize);
    defer speaker.free();

    try speaker.say("Hello, world!");
}

test "speak" {
    const bufsize: usize = 1024;
    const speaker = try speak.Speaker.new(bufsize);
    defer speaker.free();

    try speaker.say("Hello, world!");
}
