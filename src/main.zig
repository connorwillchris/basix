const std = @import("std");
const speaker = @import("speaker.zig");
const scanner = @import("scanner.zig");

pub fn main() !void {
    std.debug.print("Hello, world!\n", .{});
    const bufsize = 1024;
    const speak = try speaker.Speaker.new(bufsize);
    defer speak.free();

    try speak.say("Hello, world!");
}

test "speak" {
    const bufsize: usize = 1024;
    const s = try speaker.Speaker.new(bufsize);
    defer s.free();

    try s.say("Hello, world!");
}
